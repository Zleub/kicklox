class UsersController < ApplicationController
  def index
    render :json => User.all
  end

  def show
    render :json => User.find(params[:id])
  end

  def create
    user = User.new(name: params[:name])

    user_save user
  end

  def update
    user = User.find(params[:id])

    user.attributes = {
      name: params[:name]
    }

    user_save user
  end
  
  def destroy
    if User.find(params[:id]).destroy
      render status: :ok,
          json: {
            status: :ok
          }
      end
  end

  private
  def user_save(user)
    if user.save!
      render status: :created,
        json: {
          status: :created
        }
    else
      render status: :bad_request,
        json: {
          status: :bad_request
        }
    end
  end

end
