require 'spec_helper'

describe BugsController do 
  describe "GET#new" do 
    it "sets the @bug variable" do 
      get :new
      expect(assigns(:bug)).to be_instance_of(Bug)
    end
  end
end