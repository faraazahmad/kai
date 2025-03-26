class NotesController < ApplicationController
  before_action :set_note, only: %i[ show edit update destroy ]

  inertia_share flash: -> { flash.to_hash }

  # GET /notes
  def index
    @notes = Note.all
    render inertia: 'Note/Index', props: {
      notes: @notes.map do |note|
        serialize_note(note)
      end
    }
  end

  # GET /notes/1
  def show
    render inertia: 'Note/Show', props: {
      note: serialize_note(@note)
    }
  end

  # GET /notes/new
  def new
    @note = Note.new
    render inertia: 'Note/New', props: {
      note: serialize_note(@note)
    }
  end

  # GET /notes/1/edit
  def edit
    render inertia: 'Note/Edit', props: {
      note: serialize_note(@note)
    }
  end

  # POST /notes
  def create
    @note = Note.new(note_params)

    if @note.save
      redirect_to submission_url(@note.submission), inertia: { errors: @note.errors }
      # redirect_to @note, notice: "Note was successfully created."
    else
      redirect_to new_note_url, inertia: { errors: @note.errors }
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update(note_params)
      redirect_to @note, notice: "Note was successfully updated."
    else
      redirect_to edit_note_url(@note), inertia: { errors: @note.errors }
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy!
    redirect_to notes_url, notice: "Note was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:content, :user_id, :submission_id)
    end

    def serialize_note(note)
      note.as_json(only: [
        :id, :content, :user_id, :submission_id
      ])
    end
end
