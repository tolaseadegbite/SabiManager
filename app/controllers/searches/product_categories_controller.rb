class Searches::ProductCategoriesController < ApplicationController
  def show
    @product_categories = ProductCategory.where("name like :query", query: "%#{params[:q]}%").order(:name)
  end
end
