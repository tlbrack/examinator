require 'rails_helper'

RSpec.describe "/colleges", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # College. As you add validations to College, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      name: 'Everlearn'
    }
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # CollegesController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      College.create! valid_attributes
      get colleges_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      college = College.create! valid_attributes
      get college_url(college), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new College" do
        expect {
          post colleges_url,
               params: { college: valid_attributes }, headers: valid_headers, as: :json
        }.to change(College, :count).by(1)
      end

      it "renders a JSON response with the new college" do
        post colleges_url,
             params: { college: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new College" do
        expect {
          post colleges_url,
               params: { college: invalid_attributes }, as: :json
        }.to change(College, :count).by(0)
      end

      it "renders a JSON response with errors for the new college" do
        post colleges_url,
             params: { college: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          name: 'Neverlearn'
        }
      }

      it "updates the requested college" do
        college = College.create! valid_attributes
        patch college_url(college),
              params: { college: new_attributes }, headers: valid_headers, as: :json
        college.reload
        expect(college.name).to eq 'Neverlearn'
      end

      it "renders a JSON response with the college" do
        college = College.create! valid_attributes
        patch college_url(college),
              params: { college: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the college" do
        college = College.create! valid_attributes
        patch college_url(college),
              params: { college: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested college" do
      college = College.create! valid_attributes
      expect {
        delete college_url(college), headers: valid_headers, as: :json
      }.to change(College, :count).by(-1)
    end
  end
end
