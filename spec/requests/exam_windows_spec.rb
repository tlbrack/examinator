require 'rails_helper'

RSpec.describe "/exam_windows", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # ExamWindow. As you add validations to ExamWindow, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      starts_at: 1.hour.ago,
      ends_at: 1.hour.since,
      exam_id: exam.id
    }
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # ExamWindowsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  let!(:exam) { create(:exam) }

  describe "GET /index" do
    it "renders a successful response" do
      ExamWindow.create! valid_attributes
      get exam_windows_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      exam_window = ExamWindow.create! valid_attributes
      get exam_window_url(exam_window), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new ExamWindow" do
        expect {
          post exam_windows_url,
               params: { exam_window: valid_attributes }, headers: valid_headers, as: :json
        }.to change(ExamWindow, :count).by(1)
      end

      it "renders a JSON response with the new exam_window" do
        post exam_windows_url,
             params: { exam_window: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new ExamWindow" do
        expect {
          post exam_windows_url,
               params: { exam_window: invalid_attributes }, as: :json
        }.to change(ExamWindow, :count).by(0)
      end

      it "renders a JSON response with errors for the new exam_window" do
        post exam_windows_url,
             params: { exam_window: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          starts_at: 2.hours.ago,
          ends_at: 2.hours.since
        }
      }

      it "updates the requested exam_window" do
        exam_window = ExamWindow.create! valid_attributes
        patch exam_window_url(exam_window),
              params: { exam_window: new_attributes }, headers: valid_headers, as: :json
        exam_window.reload
        expect(exam_window.starts_at).to be_within(2.seconds).of(2.hours.ago)
        expect(exam_window.ends_at).to be_within(2.seconds).of(2.hours.since)
      end

      it "renders a JSON response with the exam_window" do
        exam_window = ExamWindow.create! valid_attributes
        patch exam_window_url(exam_window),
              params: { exam_window: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the exam_window" do
        exam_window = ExamWindow.create! valid_attributes
        patch exam_window_url(exam_window),
              params: { exam_window: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested exam_window" do
      exam_window = ExamWindow.create! valid_attributes
      expect {
        delete exam_window_url(exam_window), headers: valid_headers, as: :json
      }.to change(ExamWindow, :count).by(-1)
    end
  end
end
