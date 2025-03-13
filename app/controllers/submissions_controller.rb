class SubmissionsController < ApplicationController
  before_action :set_submission, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  inertia_share flash: -> { flash.to_hash }

  # GET /submissions
  def index
    @submissions = Submission.all
    render inertia: 'Submission/Index', props: {
      submissions: @submissions.map do |submission|
        serialize_submission(submission)
      end
    }
  end

  # GET /submissions/1
  def show
    render inertia: 'Submission/Show', props: {
      submission: serialize_submission(@submission)
    }
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
    render inertia: 'Submission/New', props: {
      submission: serialize_submission(@submission)
    }
  end

  # GET /submissions/1/edit
  def edit
    render inertia: 'Submission/Edit', props: {
      submission: serialize_submission(@submission)
    }
  end

  # POST /submissions
  def create
    @submission = Submission.new(submission_params)
    @submission.status = 'Awaiting Processing'
    @submission.user_id = current_user.id

    if @submission.save
      GetSubmissionContentJob.perform_later(@submission.id)
      redirect_to @submission, notice: "Submission was successfully created."
    else
      redirect_to new_submission_url, inertia: { errors: @submission.errors }
    end
  end

  # PATCH/PUT /submissions/1
  def update
    if @submission.update(submission_params)
      redirect_to @submission, notice: "Submission was successfully updated."
    else
      redirect_to edit_submission_url(@submission), inertia: { errors: @submission.errors }
    end
  end

  # DELETE /submissions/1
  def destroy
    @submission.destroy!
    redirect_to submissions_url, notice: "Submission was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def submission_params
      params.require(:submission).permit(:title, :url, :user_id, :content, :status, :submission_type)
    end

    def serialize_submission(submission)
      submission.as_json(only: [
        :id, :title, :url, :user_id, :content, :status, :submission_type
      ])
    end
end
