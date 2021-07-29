class UsersController < ApplicationController
  # get all users
  def index
    render :json => User.all
  end

  # get one user based on the id
  def show
    render :json => User.find(params[:id])
  end

  # create a user
  def create
    user = User.new(name: params[:name])

    user_save user
  end

  # update a user based on the id
  def update
    user = User.find(params[:id])

    user.attributes = {
      name: params[:name]
    }

    user_save user
  end

  # destroy a user based on the id
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
