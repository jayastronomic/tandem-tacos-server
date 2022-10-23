class Api::V1::RecipesController < ApplicationController
  before_action :find_recipe
  skip_before_action :find_recipe, only: %w(create)

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      render json: @recipe
    else 
      render json: { status: 500, errors: @recipe.errors.full_messages }
    end
  end

  def show
    render json: @recipe
  end

  def destroy
    @recipe.destroy
    render json: @recipe 
  end

  def update 
    @recipe.update(recipe_params)
    render json: @recipe
  end

  private

  def find_recipe
    @recipe = Recipe.find(recipe_params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :description,
      tags: [],
      ingredients: [],
      :image
    )
  end
end
