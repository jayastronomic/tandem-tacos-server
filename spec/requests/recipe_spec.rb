require 'rails_helper'

RSpec.describe 'Recipes API:', type: :request do
  describe 'POST /recipes' do
    let(:recipe_params) {
      { recipe:
        { 
          name: Faker::Food.dish, 
          directions: [Faker::Food.description, Faker::Food.description],
          user_id: 4 
        }
      }
    }
    let(:invalid_recipe_params) {
      { recipe: 
        { 
          name: Faker::Food.dish, 
          directions: '',
          user_id: 4
        }
      }
    }
    context "when recipe params are valid" do
      before(:each) do 
        post '/api/v1/recipes', params: recipe_params
      end

      let(:new_recipe) { JSON.parse(response.body).deep_symbolize_keys }

      it 'creates a new recipe' do
        expect { (Recipe.count).to change.from(0).to(1) }
      end

      it 'returns status :created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns a new recipe' do
        expect([JSON.parse(response.body)].size).to eq(1)
      end
    end

    context 'when recipe params are invalid' do
      before(:each) do 
        post '/api/v1/recipes', params: invalid_recipe_params
      end

      let(:invalid_recipe) { JSON.parse(response.body).deep_symbolize_keys }
    
      it 'returns error messages' do
        expect(invalid_recipe[:errors].length).to be >= 1
      end

      it "doesn't create a new recipe" do 
        expect(Recipe.count).to eq(0)
      end

      it "returns status :unprocessable_entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /recipes/:uuid' do
    context 'when recipe is deleted' do
    let!(:recipe_one) { FactoryBot.create(:recipe) }
    let!(:recipe_two) { FactoryBot.create(:recipe) }

      before(:each) do
        delete "/api/v1/recipes/#{recipe_one.uuid}"
      end

      it 'Recipe count goes down' do 
        expect(Recipe.count).to eq(1)
      end
    
      it 'returns deleted recipe' do 
        expect([JSON.parse(response.body)].size).to eq(1)
      end
      
      it 'returns status code 200' do
        expect(response).to  have_http_status(200)
      end
    end
  end

  describe 'PATCH api/v1/recipes' do
    let!(:recipe) { FactoryBot.create(:recipe) }
    let(:valid_recipe_params) { { recipe: { name: Faker::Name.name } } }
    let(:invalid_recipe_params) { { recipe: { name: ' ' } } }

    context 'when recipe params are valid' do
      before(:each) do
        patch "/api/v1/recipes/#{recipe.uuid}", params: valid_recipe_params
      end

      let(:updated_recipe) { JSON.parse(response.body).deep_symbolize_keys }

      it 'updates recipe' do
        expect(recipe.name).to_not eq(updated_recipe[:name])
      end 

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when recipe params are invalid' do
      before(:each) do
        patch "/api/v1/recipes/#{recipe.uuid}", params: invalid_recipe_params
      end

      it "it doesn't update recipe" do
        expect(recipe.name).to_not eq(invalid_recipe_params[:recipe][:name])
      end 
    end
  end

  describe 'GET /recipes/:uuid' do
    let(:recipe) { FactoryBot.create(:recipe) }

    context 'when recipe is loaded' do
      before do 
        get "/api/v1/recipes/#{recipe.uuid}" 
      end

      it 'returns recipe' do 
        expect([JSON.parse(response.body)].size).to eq(1)
      end
      
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end