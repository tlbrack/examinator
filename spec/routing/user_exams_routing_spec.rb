require "rails_helper"

RSpec.describe UserExamsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/user_exams").to route_to("user_exams#index")
    end

    it "routes to #show" do
      expect(get: "/user_exams/1").to route_to("user_exams#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/user_exams").to route_to("user_exams#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/user_exams/1").to route_to("user_exams#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/user_exams/1").to route_to("user_exams#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/user_exams/1").to route_to("user_exams#destroy", id: "1")
    end
  end
end
