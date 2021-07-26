class MessagesController < ApplicationController
  def index
    render :json => Message.all
  end

  def show
    render :json => Message.find(params[:id])
  end

  def by_recipient
    render :json => Message.where(recipient: params[:id])
  end

  def create
    message = Message.new(
      body: parse_body(params[:body]),
      public: params[:public],
      author: User.find(params[:author].to_i),
      recipient: User.find(params[:recipient].to_i)
    )

    if Message.exists?(id: params[:parent])
      message.parent = Message.find(params[:parent])
    end

    message_save message
  end

  def update
    message = Message.find(params[:id])

    message.attributes = {
      body: parse_body(params[:body]),
      public: params[:public]
    }

    message_save message
  end

  def destroy
    if Message.find(params[:id]).destroy
      render status: :ok,
          json: {
            status: :ok
          }
      end
  end

  private
    def message_params
      params.require(:message).permit(:body, :public, :author, :recipient)
    end

  private
    def message_save(message)
      if message.save!
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
    def parse_body(body)
      internationalphoneRegex = /\+\d{2,3}(\s|\.)?\d{1,2}(\s|\.)?\d{2}(\s|\.)?(\s|\.)?\d{2}(\s|\.)?\d{2}(\s|\.)?\d{2}/
      phoneRegex = /\d{2}(\s|\.)?\d{2}(\s|\.)?\d{2}(\s|\.)?(\s|\.)?\d{2}(\s|\.)?\d{2}/
      emailRegex = /(\w|\.)*@(\w|\.)*/

      body.gsub(internationalphoneRegex, "confidentiel")
        .gsub(phoneRegex, "confidentiel")
        .gsub(emailRegex, "confidentiel")
    end
end
