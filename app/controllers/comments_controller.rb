class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_admin_or_author, only: [:update, :edit, :destroy]
  before_action :set_comment, only: [:show, :edit, :update, :destroy ]
  # before_action :set_note, only: [:new, :create, :show, :edit, :update, :destroy]
  
  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
    @note = Note.find(params[:note_id])
    @comment = @note.comments.find(params[:id])
  end

  # GET /comments/new
  def new
    @note = Note.find(params[:note_id])
    @comment = @note.comments.build
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @note = Note.find(params[:note_id])
    @comment = @note.comments.build(comment_params)
    @comment.user = current_user
  
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @note, notice: "Comentario creado exitosamente." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comentario actualizado exitosamente." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @note = @comment.note
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to note_path(@note), notice: "Comentario eliminado exitosamente" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :note_id)
    end
end
