class ItemsController < ApplicationController 
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index 
    if params[:user_id] 
      user = User.find(params[:user_id]) 
      items = user.items 
    else
    items = Item.all 
    end
    render json: items.to_json(except: [:created_at, :updated_at], include: :user)
  end

  def show 
    user = Item.find(params[:id]) 
    render json: user
  end  

  def create 
    item = Item.create(item_params) 
   
    render json: item, status: :created 
   

  end

  private

  def item_params 
    params.permit(:name, :description, :price, :user_id)
  end 

  def render_not_found_response
    render json: { error: "Dog house not found" }, status: :not_found
  end


end