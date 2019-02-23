require 'rails_helper'

RSpec.describe "ApiDevelopments", type: :request do
  def parsed_body
    JSON.parse(response.body)
  end

  describe "RDBMS-backed" do
    before(:each) { Foo.delete_all }
    after(:each) { Foo.delete_all }

    it "create RDBMS-backed model" do
      object=FactoryGirl.create(:foo, :name=>"test")
      expect(Foo.find(object.id).name).to eq("test")
    end

    it "create RDBMS-backed API resource" do
      object=FactoryGirl.create(:foo, :name=>"test")
      expect(foos_path).to eq("/api/foos")
      get foo_path(object.id)
      expect(response).to have_http_status(:ok)
      expect(parsed_body["name"]).to eq("test")
    end
  end

  describe "MongoDB-backed" do
    before(:each) { Foo.delete_all }
    after(:each) { Foo.delete_all }

    it "create MongoDB-backed model" do
      object=FactoryGirl.create(:bar, :name=>"test")
      expect(Bar.find(object.id).name).to eq("test")
    end

    it "create MongoDB-backed API resource" do
      object=FactoryGirl.create(:bar, :name=>"test")
      expect(bars_path).to eq("/api/bars")
      get bar_path(object.id)
      expect(response).to have_http_status(:ok)
      expect(parsed_body["name"]).to eq("test")
    end
  end
end
