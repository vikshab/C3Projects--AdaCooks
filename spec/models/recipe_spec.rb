require 'rails_helper'

RSpec.describe Recipe, type: :model do

  describe Recipe do
    it_behaves_like "an object"
  end

  describe "model validations" do

    it "Requires that a recipe preparation be present" do
      recipe = build :recipe, preparation: nil

      expect(recipe).to_not be_valid
      expect(recipe.errors.keys).to include(:preparation)
    end

    it "Requires that a recipe has at least one ingredient" do
      recipe = create :recipe

      expect(recipe.ingredients.length).to eq 1
    end
  end

  #how to get a new instance of ingredient with different name using factory girl
  describe "scope alpha_order" do
    it "Returns a list of recipes in alphabetic order" do
      recipe1 = Recipe.new(name: "Biscuits", preparation: "bake")
      ingredient1 = create :ingredient, name: "butter"
      recipe1.ingredients << ingredient1
      recipe1.save

      recipe2 = Recipe.new(name: "Salad", preparation: "bake")
      ingredient2 = create :ingredient, name: "dressing"
      recipe2.ingredients << ingredient2
      recipe2.save

      recipe3 = Recipe.new(name: "Macaronni and Cheese", preparation: "bake")
      ingredient3 = create :ingredient, name: "cheese"
      recipe3.ingredients << ingredient3
      recipe3.save

      correct_order = [recipe1, recipe3, recipe2]

      expect(Recipe.alpha_order).to eq correct_order
    end
  end
end
