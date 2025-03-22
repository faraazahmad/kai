class SubmissionsController < ApplicationController
  before_action :set_submission, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  inertia_share flash: -> { flash.to_hash }

  # GET /submissions
  def index
    @submissions = Submission.all
    render inertia: 'Submission/Index', props: {
      submissions: @submissions.map do |submission|
        {
          **serialize_submission(submission),
          tags: submission.tags.as_json(only: [:name, :id])
        }
      end
    }
  end

  # GET /submissions/1
  def show
    pdf_binary = read_pdf(@submission.title) if @submission.submission_type == 'pdf'

    render inertia: 'Submission/Show', props: {
      submission: serialize_submission(@submission),
      pdf_binary: pdf_binary,
      tags: @submission.tags
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

  def open_pdf
    submission = Submission.find(params[:id])
    title = submission.title
    file_name = "#{title.split(' ').join('_').downcase}.pdf"
    absolute_root_path = File.expand_path("~/.kai/pdfs")
    file_path = File.join(absolute_root_path, file_name)
    full_path = File.expand_path(file_path)

    if File.exist?("/proc/sys/fs/binfmt_misc/WSLInterop") # Best known way to check for WSL Linux shell
      system("wsl-open #{full_path}")
    else
      # TODO: check for Mac vs Linux (requires xdg-open)
      system("open #{full_path}")
    end

    redirect_to submission_url
  end

  private

    def read_pdf(title)
      file_name = "#{title.split(' ').join('_').downcase}.pdf"
      absolute_root_path = File.expand_path("~/.kai/pdfs")
      file_path = File.join(absolute_root_path, file_name)
      content = File.read(file_path)

      Base64.encode64(content)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def submission_params
      params.require(:submission).permit(:tags, :title, :url, :user_id, :content, :status, :submission_type)
    end

    def serialize_submission(submission)
      submission.as_json(only: [
        :id, :title, :url, :user_id, :content, :status, :submission_type, :tags, :updated_at, :updated_at_ago
      ])
    end
end
