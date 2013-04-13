require "spec_helper"

describe ContaController do
  describe "routing" do

    it "routes to #index" do
      get("/conta").should route_to("conta#index")
    end

    it "routes to #new" do
      get("/conta/new").should route_to("conta#new")
    end

    it "routes to #show" do
      get("/conta/1").should route_to("conta#show", :id => "1")
    end

    it "routes to #edit" do
      get("/conta/1/edit").should route_to("conta#edit", :id => "1")
    end

    it "routes to #create" do
      post("/conta").should route_to("conta#create")
    end

    it "routes to #update" do
      put("/conta/1").should route_to("conta#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/conta/1").should route_to("conta#destroy", :id => "1")
    end

  end
end
