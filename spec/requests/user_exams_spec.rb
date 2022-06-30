require 'rails_helper'

RSpec.describe "/user_exams", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # UserExam. As you add validations to UserExam, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      first_name: 'Jeff',
      last_name: 'Blue',
      phone_number: '+16167175555',
      college_id: college.id,
      exam_id: exam.id,
      start_time: Time.current
    }
  }

  # missing college_id
  let(:missing_attributes) {
    {
      first_name: 'Jeff',
      last_name: 'Blue',
      phone_number: '+16167175555',
      exam_id: exam.id,
      start_time: Time.current
    }
  }

  let(:college) { exam.college }

  let(:exam) { exam_window.exam }

  let(:exam_window) { create(:exam_window) }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # UserExamsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      user_exam = create(:user_exam, exam: exam)
      get user_exams_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      user_exam = create(:user_exam, exam: exam)
      get user_exam_url(user_exam), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new UserExam" do
        expect {
          post user_exams_url,
               params: valid_attributes, headers: valid_headers, as: :json
        }.to change(UserExam, :count).by(1)
      end

      it "renders a JSON response with the new user_exam" do
        post user_exams_url,
             params: valid_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with non-existent college" do
      let(:attributes) {
        {
          first_name: 'Jeff',
          last_name: 'Blue',
          phone_number: '+16167175555',
          college_id: college.id + 100,
          exam_id: exam.id,
          start_time: Time.current
        }
      }

      it "responds with an error" do
        expect {
          post user_exams_url, params: attributes, headers: valid_headers, as: :json
        }.to change(UserExam, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match("College does not exist")
      end
    end

    context "with exam college mismatch" do
      let(:attributes) {
        {
          first_name: 'Jeff',
          last_name: 'Blue',
          phone_number: '+16167175555',
          college_id: create(:college).id,
          exam_id: exam.id,
          start_time: Time.current
        }
      }

      it "responds with an error" do
        expect {
          post user_exams_url, params: attributes, headers: valid_headers, as: :json
        }.to change(UserExam, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match("Exam not offered at this college")
      end
    end

    context "with data that will fail user creation" do
      let(:attributes) {
        {
          first_name: 'Jeff',
          last_name: 'Blue',
          phone_number: '12',
          college_id: college.id,
          exam_id: exam.id,
          start_time: Time.current
        }
      }

      it "responds with an error" do
        expect {
          post user_exams_url, params: attributes, headers: valid_headers, as: :json
        }.to change(UserExam, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match("Failed to create user")
      end
    end

    context "with bad start time" do
      let(:attributes) {
        {
          first_name: 'Jeff',
          last_name: 'Blue',
          phone_number: '12',
          college_id: college.id,
          exam_id: exam.id,
          start_time: 2.days.since
        }
      }

      it "responds with an error" do
        expect {
          post user_exams_url, params: attributes, headers: valid_headers, as: :json
        }.to change(UserExam, :count).by(0)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match("No exam window is available for the start time")
      end

      it "logs the error" do
        expect {
          post user_exams_url, params: attributes, headers: valid_headers, as: :json
        }.to change(ApiLog, :count).by(1)
        expect(ApiLog.last.response_body).to match("No exam window")
      end
    end
  
    context "with missing attribute" do
      it "raises an exception that would respond with errors for the new user_exam" do
        expect {
          post user_exams_url,
              params: missing_attributes, headers: valid_headers, as: :json
        }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  describe "PATCH /update", skip: true do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          starts_at: 1.hour.since
        }
      }

      it "updates the requested user_exam" do
        user_exam = UserExam.create! valid_attributes
        patch user_exam_url(user_exam),
              params: { user_exam: new_attributes }, headers: valid_headers, as: :json
        user_exam.reload
        expect(user_exam.starts_at).to be_within(2.seconds).of(1.hour.since)
      end

      it "renders a JSON response with the user_exam" do
        user_exam = UserExam.create! valid_attributes
        patch user_exam_url(user_exam),
              params: { user_exam: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the user_exam" do
        user_exam = UserExam.create! valid_attributes
        patch user_exam_url(user_exam),
              params: { user_exam: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested user_exam" do
      user_exam = create(:user_exam, exam: exam)
      expect {
        delete user_exam_url(user_exam), headers: valid_headers, as: :json
      }.to change(UserExam, :count).by(-1)
    end
  end
end
