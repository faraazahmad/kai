class HighlightsController < ApplicationController
  before_action :set_highlight, only: %i[ show edit update destroy ]

  # GET /highlights or /highlights.json
  def index
    @highlights = Highlight.all
  end

  # GET /highlights/1 or /highlights/1.json
  def show
  end

  # GET /highlights/new
  def new
    @highlight = Highlight.new
  end

  # GET /highlights/1/edit
  def edit
  end

  # POST /highlights or /highlights.json
  def create
    @highlight = Highlight.new(highlight_params)

    respond_to do |format|
      if @highlight.save
        format.html { redirect_to @highlight, notice: "Highlight was successfully created." }
        format.json { render :show, status: :created, location: @highlight }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @highlight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /highlights/1 or /highlights/1.json
  def update
    respond_to do |format|
      if @highlight.update(highlight_params)
        format.html { redirect_to @highlight, notice: "Highlight was successfully updated." }
        format.json { render :show, status: :ok, location: @highlight }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @highlight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /highlights/1 or /highlights/1.json
  def destroy
    @highlight.destroy!

    respond_to do |format|
      format.html { redirect_to highlights_path, status: :see_other, notice: "Highlight was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_highlight
      @highlight = Highlight.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def highlight_params
      params.expect(highlight: [ :text, :submission_id ])
    end
end
