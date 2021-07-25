class MessagesController < ApplicationController
  def index
    response.set_header('HEADER-NAME', 'HEADER VALUE')
    render :json => Message.all
  end

  def show
    render :json => Message.find(params[:id])
  end

  def create
    @message = Message.new(
      body: params[:body],
      public: params[:public],
      author: User.find(params[:author].to_i),
      recipient: User.find(params[:author].to_i)
    )

    if @message.save!
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

  private
    def message_params
      params.require(:message).permit(:body, :public, :author, :recipient)
    end
end
