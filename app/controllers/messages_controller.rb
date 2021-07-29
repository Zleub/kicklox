class MessagesController < ApplicationController
  # get all messages
  def index
    render :json => Message.all
  end

  # get one message based on the id
  def show
    render :json => Message.find(params[:id])
  end

  #get messages from oldest to newest based on a recipient id
  def by_recipient
    render :json => Message.order('created_at').where(recipient: params[:id])
  end

  #create a new message
  def create
    message = Message.new(
      body: replace_phone_and_email(params[:body]),
      public: params[:public],
      author: User.find(params[:author]),
      recipient: User.find(params[:recipient])
    )

    if Message.exists?(id: params[:parent])
      message.parent = Message.find(params[:parent])
    end

    message_save message
  end

  #update a message based on the id
  def update
    message = Message.find(params[:id])

    message.attributes = {
      body: replace_phone_and_email(params[:body]),
      public: params[:public]
    }

    message_save message
  end

  #destroy a message based on the id
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
    # shortcut for saving a message
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
    # function to replace a phone or email in a body message
    def replace_phone_and_email(body)
      if body
        internationalphoneRegex = /\+\d{2,3}(\s|\.)?\d{1,2}(\s|\.)?\d{2}(\s|\.)?(\s|\.)?\d{2}(\s|\.)?\d{2}(\s|\.)?\d{2}/
        phoneRegex = /\d{2}(\s|\.)?\d{2}(\s|\.)?\d{2}(\s|\.)?(\s|\.)?\d{2}(\s|\.)?\d{2}/
        emailRegex = /(\w|\.)*@(\w|\.)*/

        body.gsub(internationalphoneRegex, "confidentiel")
          .gsub(phoneRegex, "confidentiel")
          .gsub(emailRegex, "confidentiel")
      end
    end
end
