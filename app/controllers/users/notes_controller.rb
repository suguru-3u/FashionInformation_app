class Users::NotesController < ApplicationController
  before_action :note_information, only: [:edit, :update, :destroy]

  def index
    @note = Note.new
    @notes = current_user.notes
  end

  def create
    @note = current_user.notes.new(notes_params)
    if @note.save
      respond_to do |format|
        format.html { redirect_to(users_notes_path) }
        format.json
      end
    else
      @notes = current_user.notes
      render(:index)
    end
  end

  def edit
  end

  def update
    @note.update(notes_params) ? redirect_to(users_notes_path) : render(:edit)
  end

  def destroy
    @note.destroy ? redirect_to(users_notes_path) : render(:index)
  end

  private

  def notes_params
    params.require(:note).permit(:note_title, :note_body, :post_image)
  end

  def note_information
    @note = Note.find(params[:id])
  end
end
