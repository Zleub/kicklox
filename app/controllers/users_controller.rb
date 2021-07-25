class UsersController < ApplicationController
  def index
    render :json => User.all
  end

  def create
    @user = User.new(name: params[:name])

    if @user.save
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
