
require 'rails_helper'

RSpec.describe 'Users API:', type: :request do
  describe 'POST /users' do
    let(:user_params) {
      { user:
        { 
          name: Faker::Name.name, 
          username: Faker::Internet.username( separators: %w(_)), 
          email: Faker::Internet.email(separators: ''), 
          password: Faker::Internet.password,
        }
      }
    }
    let(:invalid_user_params) {
      { user: 
        { 
          name: Faker::Name.name, 
          username: Faker::Internet.username( separators: %w(_)), 
          email: Faker::Internet.email(separators: ''), 
          password: ''
        }
      }
    }
    context "when user params are valid" do
      before(:each) do 
        post '/api/v1/users', params: user_params
      end

      let(:new_user) { JSON.parse(response.body).deep_symbolize_keys }

      it 'creates a new user' do
        expect { (User.count).to change.from(0).to(1) }
      end

      it 'logs in a user' do
        expect(session[:user_uuid]).to eq(new_user[:uuid])
      end

      it 'returns status :created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns a new user' do
        expect([JSON.parse(response.body)].size).to eq(1)
      end
    end

    context 'when user params are invalid' do
      before(:each) do 
        post '/api/v1/users', params: invalid_user_params
      end

      let(:invalid_user) { JSON.parse(response.body).deep_symbolize_keys }
    
      it 'returns error messages' do
        expect(invalid_user[:errors].length).to be >= 1
      end

      it "doesn't create a new user" do 
        expect(User.count).to eq(0)
      end

      it "returns status :unprocessable_entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /users/:uuid' do
    context 'when user is deleted' do
    let!(:user_one) { FactoryBot.create(:user) }
    let!(:user_two) { FactoryBot.create(:user) }

      before(:each) do
        delete "/api/v1/users/#{user_one.uuid}"
      end

      it 'User count goes down' do 
        expect(User.count).to eq(1)
      end
    
      it 'returns deleted user' do 
        expect([JSON.parse(response.body)].size).to eq(1)
      end
      
      it 'returns status code 200' do
        expect(response).to  have_http_status(200)
      end
    end
  end

  describe 'PATCH api/v1/users' do
    let!(:user) { FactoryBot.create(:user) }
    let(:valid_user_params) { { user: { name: Faker::Name.name } } }
    let(:invalid_user_params) { { user: { username: Faker::Internet.username( separators: %w(&)) } } }

    context 'when user params are valid' do
      before(:each) do
        patch "/api/v1/users/#{user.uuid}", params: valid_user_params
      end

      let(:updated_user) { JSON.parse(response.body).deep_symbolize_keys }

      it 'updates user' do
        expect(user.name).to_not eq(updated_user[:name])
      end 

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when user params are invalid' do
      before(:each) do
        patch "/api/v1/users/#{user.uuid}", params: invalid_user_params
      end

      it "it doesn't update user" do
        expect(user.username).to_not eq(invalid_user_params[:user][:username])
      end 

      # it 'returns status code 422' do
      #   expect(response).to have_http_status(422)
      # end
    end
  end

  describe 'GET /users/:uuid' do
    let(:user) { FactoryBot.create(:user) }

    context 'when user is loaded' do
      before do 
        get "/api/v1/users/#{user.uuid}" 
      end

      it 'returns user' do 
        expect([JSON.parse(response.body)].size).to eq(1)
      end
      
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end