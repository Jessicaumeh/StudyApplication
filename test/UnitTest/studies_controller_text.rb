require 'rails_helper'

RSpec.describe StudiesController, type: :controller do
  # Create sample data for tests
  let!(:study1) { Study.create(title: "Study 1", started: false, completed: false) }
  let!(:study2) { Study.create(title: "Study 2", started: true, completed: false) }

  # Strong parameters for create and update actions
  let(:valid_attributes) { { title: "New Study", started: true, completed: false } }
  let(:invalid_attributes) { { title: nil, started: true, completed: false } }

  describe "GET #index" do
    it "returns a success response" do
      get :index, format: :json
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "GET #show" do
    it "returns a success response for an existing study" do
      get :show, params: { id: study1.id }, format: :json
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response["title"]).to eq(study1.title)
    end

    it "returns a not found response for a non-existent study" do
      get :show, params: { id: 999 }, format: :json
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new study" do
        expect {
          post :create, params: { study: valid_attributes }, format: :json
        }.to change(Study, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new study" do
        expect {
          post :create, params: { study: invalid_attributes }, format: :json
        }.not_to change(Study, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH/PUT #update" do
    context "with valid parameters" do
      it "updates the requested study" do
        patch :update, params: { id: study1.id, study: { title: "Updated Title" } }, format: :json
        expect(response).to have_http_status(:ok)
        study1.reload
        expect(study1.title).to eq("Updated Title")
      end
    end

    context "with invalid parameters" do
      it "does not update the study" do
        patch :update, params: { id: study1.id, study: { title: nil } }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
        study1.reload
        expect(study1.title).not_to eq(nil)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the requested study" do
      expect {
        delete :destroy, params: { id: study1.id }, format: :json
      }.to change(Study, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end

    it "returns not found for a non-existent study" do
      expect {
        delete :destroy, params: { id: 999 }, format: :json
      }.not_to change(Study, :count)
      expect(response).to have_http_status(:not_found)
    end
  end
end
