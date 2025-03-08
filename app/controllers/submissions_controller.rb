class SubmissionsController < ApplicationController
  before_action :set_submission, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  inertia_share do
    {
      user: current_user,
    } if user_signed_in?
  end

  # GET /submissions or /submissions.json
  def index
    @submissions = Submission.all
  end

  # GET /submissions/1 or /submissions/1.json
  def show
    render inertia: "Submissions/Show", props: {
      submission: @submission,
      path: submissions_url
    }
  end

  # GET /submissions/new
  def new
    submission = Submission.new

    render inertia: "Submissions/New", props: {
      submission: submission,
      path: submissions_url
    }
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions or /submissions.json
  def create
    @submission = Submission.new(submission_params)
    @submission.user = current_user

    respond_to do |format|
      if @submission.save
        format.html { redirect_to @submission, notice: "Submission was successfully created." }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submissions/1 or /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: "Submission was successfully updated." }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1 or /submissions/1.json
  def destroy
    @submission.destroy!

    respond_to do |format|
      format.html { redirect_to submissions_path, status: :see_other, notice: "Submission was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def submission_params
      params.expect(submission: [ :title, :status, :user_id, :url, :content ])
    end
end
