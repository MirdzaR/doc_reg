require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context "GET # new" do
    it 'has a 200 status code' do
      get :new
      expect(response.status).to eq(200)
    end

    it 'Renders :new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end
end
