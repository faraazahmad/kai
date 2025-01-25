class SubmissionTypesController < ApplicationController
  before_action :set_submission_type, only: %i[ show edit update destroy ]

  # GET /submission_types or /submission_types.json
  def index
    @submission_types = SubmissionType.all
  end

  # GET /submission_types/1 or /submission_types/1.json
  def show
  end

  # GET /submission_types/new
  def new
    @submission_type = SubmissionType.new
  end

  # GET /submission_types/1/edit
  def edit
  end

  # POST /submission_types or /submission_types.json
  def create
    @submission_type = SubmissionType.new(submission_type_params)

    respond_to do |format|
      if @submission_type.save
        format.html { redirect_to @submission_type, notice: "Submission type was successfully created." }
        format.json { render :show, status: :created, location: @submission_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @submission_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submission_types/1 or /submission_types/1.json
  def update
    respond_to do |format|
      if @submission_type.update(submission_type_params)
        format.html { redirect_to @submission_type, notice: "Submission type was successfully updated." }
        format.json { render :show, status: :ok, location: @submission_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @submission_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submission_types/1 or /submission_types/1.json
  def destroy
    @submission_type.destroy!

    respond_to do |format|
      format.html { redirect_to submission_types_path, status: :see_other, notice: "Submission type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission_type
      @submission_type = SubmissionType.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def submission_type_params
      params.expect(submission_type: [ :name ])
    end
end
