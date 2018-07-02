class RecipesController < ApplicationController
    before_action :find_recipe, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]


    def index
        @recipe = Recipe.all.order("created_at DESC")
    end

    def show
    end

    def new
		@recipe = current_user.recipes.build
    end

    def create
        @recipe = current_user.recipes.build(recipe_params)

        respond_to do |format|
            if @recipe.save
                format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
                format.json { render :show, status: :created, location: @recipe }
            else
                format.html { render :new }
                format.json { render json: @recipe.errors, status: :unprocessable_entity }
            end
        end
    end

    def edit
    end

    def update
        if @recipe.update(recipe_params)
            redirect_to @recipe,
             notice: flash.now[:alert] = 'Updated Recipe!'
        else
            render 'edit'
        end
    end

    def destroy
        @recipe.destroy
        redirect_to root_path, notice: 'Successfully deleted recipe'
    end




    private

    def recipe_params
        params.require(:recipe).permit(:title, :description, :image, ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])

    end

    def find_recipe
        @recipe = Recipe.find(params[:id])
    end
end
