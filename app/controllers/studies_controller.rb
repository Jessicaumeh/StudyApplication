class StudiesController < ApplicationController
  before_action :set_study, only: %i[ show edit update destroy ]

  # GET /studies or /studies.json
  def index
    @studies = Study.all
    render json: @studies
  end

  # GET /studies/1 or /studies/1.json
  def show
    render json: @study
  end

  # GET /studies/new
  def new
    @study = Study.new
  end

  # GET /studies/1/edit
  def edit
  end

  # POST /studies or /studies.json
  def create
    @study = Study.new(study_params)

   
      if @study.save
        render json: @study, status: :created 
      else
         render json: @study.errors, status: :unprocessable_entity 
      end
    end
  

 # PATCH/PUT /studies/1 or /studies/1.json
 def update
  if @study.update(study_params)
    render json: @study, status: :ok # Respond with the updated study in JSON
  else
    render json: @study.errors, status: :unprocessable_entity
  end
end

# DELETE /studies/1 or /studies/1.json
def destroy
  @study.destroy
  head :no_content # Respond with no content
end

private

# Use callbacks to share common setup or constraints between actions.
def set_study
  @study = Study.find(params[:id])
end

# Only allow a list of trusted parameters through.
def study_params
  params.require(:study).permit(:title, :started, :completed)
end
end
