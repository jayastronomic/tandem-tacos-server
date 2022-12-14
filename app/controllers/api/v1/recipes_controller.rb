class Api::V1::RecipesController < ApplicationController
  before_action :find_recipe
  skip_before_action :find_recipe, only: %w(create user_recipes)

  def index
    @recipes = Recipe.order(created_at: :desc)
    render json: @recipes
  end

  def create
    parsed_ingredients = params[:ingredients].map { |ingredient| JSON.parse(ingredient) }
    @recipe = Recipe.new do |r|
        r.name = recipe_params[:name]
        r.directions = recipe_params[:directions]
        r.ingredients.build(parsed_ingredients)
        r.restrictions = recipe_params[:restrictions]
        r.uuid = SecureRandom.uuid
        r.user_id = recipe_params[:user_id]
        r.image = recipe_params[:image]
    end               
    if @recipe.save
      render json: @recipe, status: :created
    else 
      render json: { errors: @recipe.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy
    render json: @recipe, status: 200
  end

  def update 
    if @recipe.update(recipe_params)
      render json: @recipe, status: 200
    else
      render json: { errors: @recipe.errors.full_messages }, status: 422
    end
  end

  def show
    render json: @recipe, status: 200
  end

  def user_recipes
    @user_recipes = current_user.recipes
    render json: @user_recipes
  end

  private

  def find_recipe
    @recipe = Recipe.find_by(uuid: params[:uuid])
  end

  def recipe_params
    params.require(:recipe).permit(
      :name,
      [directions: []],
      [ingredients: [:name, :quantity, :preparation]],
      [restrictions: []],
      :user_id,
      :image
    )
  end
end
