class Admin::CategoriesController < ApplicationController

    def show
        @category = Category.find(params[:id])
        @products = @category.products.order(created_at: :desc)
      end

    def index 
        @category = Category.order(:name).all 
    end 

    def new 
        @category = Category.new 
    end

    def create 
        @category = Category.new(category_params)

        if  @category.save
            redirect_to [:admin, :categories], notice: "new class created"

        else 
            render :new
        end
    end     

    private 

    def category_params 
        params.require(:category).permit(:name)
    end 
end
