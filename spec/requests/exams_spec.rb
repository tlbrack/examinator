require 'rails_helper'

RSpec.describe "/exams", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Exam. As you add validations to Exam, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      name: 'Midterm',
      college_id: college.id
    }
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:college) {
    create(:college)
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # ExamsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Exam.create! valid_attributes
      get exams_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      exam = Exam.create! valid_attributes
      get exam_url(exam), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Exam" do
        expect {
          post exams_url,
               params: { exam: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Exam, :count).by(1)
      end

      it "renders a JSON response with the new exam" do
        post exams_url,
             params: { exam: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Exam" do
        expect {
          post exams_url,
               params: { exam: invalid_attributes }, as: :json
        }.to change(Exam, :count).by(0)
      end

      it "renders a JSON response with errors for the new exam" do
        post exams_url,
             params: { exam: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          name: 'Final'
        }
      }

      it "updates the requested exam" do
        exam = Exam.create! valid_attributes
        patch exam_url(exam),
              params: { exam: new_attributes }, headers: valid_headers, as: :json
        exam.reload
        expect(exam.name).to eq 'Final'
      end

      it "renders a JSON response with the exam" do
        exam = Exam.create! valid_attributes
        patch exam_url(exam),
              params: { exam: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the exam" do
        exam = Exam.create! valid_attributes
        patch exam_url(exam),
              params: { exam: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested exam" do
      exam = Exam.create! valid_attributes
      expect {
        delete exam_url(exam), headers: valid_headers, as: :json
      }.to change(Exam, :count).by(-1)
    end
  end
end
