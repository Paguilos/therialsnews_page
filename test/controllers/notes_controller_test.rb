require "test_helper"

class NotesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @note = notes(:one)
  end

  test "should get index" do
    get notes_url
    assert_response :success
  end

  test "should get new" do
    sign_in users(:one)
    get new_note_url
    assert_response :success

  end

  test "should create note" do
    sign_in users(:one)
    assert_difference("Note.count") do
      post notes_url, params: { note: { content: @note.content, image: @note.image, title: @note.title, user_id: @note.user_id } }
    end

    assert_redirected_to note_url(Note.last)
  end

  test "should show note" do
    get note_url(@note)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:one)
    get edit_note_url(@note)
    assert_response :success
  end

  test "should update note" do
    sign_in users(:one)
    patch note_url(@note), params: { note: { content: @note.content, image: @note.image, title: @note.title, user_id: @note.user_id } }
    assert_redirected_to note_url(@note)
  end

  test "should destroy note" do
    sign_in users(:one)
    assert_difference("Note.count", -1) do
      delete note_url(@note)
    end

    assert_redirected_to notes_url
  end
end
