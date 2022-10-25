class Api::V1::RecipesController < ApplicationController
  before_action :find_recipe
  skip_before_action :find_recipe, only: %w(create)

  def create
    recipe = Recipe.new(recipe_params)
    if recipe.save
      @recipe = Recipe.find(recipe.id)
      render json: @recipe, status: :created
    else 
      render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
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

  private

  def find_recipe
    @recipe = Recipe.find_by(uuid: params[:uuid])
  end

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :description,
      [tags: []],
      [ingredients: []],
      :image
    )
  end
end
