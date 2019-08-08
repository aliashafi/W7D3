require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context 'when creation successful' do
      it "creates a new user and renders show page" do
        post :create, params: {user:{username: 'ernie', password: '123456'}}
        user = User.find_by(username: 'ernie')
        expect(response).to redirect_to(user_url(user))
      end

      it 'logs the user in' do
        post :create, params: { user: {username: 'ernie', password: '123456'} }
        # user = User.find_by(username: 'ernie')
        expect(session[:session_token]).to_not be_nil
      end
    end

    context 'when creation not successful' do
      it 'flashes errors' do
        post :create, params: {user:{username: nil, password: '123456'}}
        expect(flash[:errors]).to be_present
      end

      it 'renders new template' do
        post :create, params: {user:{username: nil, password: '123456'}}
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #show" do
    it "renders show page" do
      u1 = User.create!(username: 'ernie', password: '123456')
      # debugger
      get :show, params: { id: u1.id }
      expect(response).to render_template(:show)
    end
  end

end
