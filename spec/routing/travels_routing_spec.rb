require "spec_helper"

describe TravelsController do
  describe "routing" do

    it "routes to #index" do
      get("/travels").should route_to("travels#index")
    end

    it "routes to #new" do
      get("/travels/new").should route_to("travels#new")
    end

    it "routes to #show" do
      get("/travels/1").should route_to("travels#show", :id => "1")
    end

    it "routes to #edit" do
      get("/travels/1/edit").should route_to("travels#edit", :id => "1")
    end

    it "routes to #create" do
      post("/travels").should route_to("travels#create")
    end

    it "routes to #update" do
      put("/travels/1").should route_to("travels#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/travels/1").should route_to("travels#destroy", :id => "1")
    end

  end
end
