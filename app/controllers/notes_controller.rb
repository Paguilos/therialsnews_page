class NotesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_admin, only: [:new, :create, :update, :edit, :destroy] 
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  # before_action only: [:new, :create, :update, :edit, :destroy] do
  #   authorize_request(["admin"])
  #  end
 

  # GET /notes or /notes.json
  def index
    @notes = Note.all         
  end

  # GET /notes/1 or /notes/1.json
  def show       
    @note = Note.find(params[:id])
    @comments = @note.comments
  end

  # GET /notes/new
  def new
    @note = Note.new
   
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes or /notes.json
  def create
    @note = Note.new(note_params)   
    @note.user = current_user   

      respond_to do |format|
        if @note.save
          format.html { redirect_to @note, notice: "Noticia creada exitosamente." }
          format.json { render :show, status: :created, location: @note }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @note.errors, status: :unprocessable_entity }
        end
      end   
  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: "Noticia actualizada exitosamente." }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy

    respond_to do |format|
      format.html { redirect_to home_index_path, notice: "Noticia eliminada exitosamente." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:title, :content, :image)
    end

    def authorize_admin
      unless current_user.admin?
        redirect_to notes_path, notice: "No estás autorizado a crear noticias ."
      end
    end
end
