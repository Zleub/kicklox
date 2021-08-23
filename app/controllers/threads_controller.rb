class ThreadsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
    rescue_from ActiveRecord::RecordInvalid, :with => :record_not_found

    # get all threads ids
    def index
        render :json => Message.where.not(parent: nil).distinct.pluck(:parent_id)
    end

    # get a thread based on a message id
    def show
        render :json => [Message.find(params[:id])] + Message.where(parent: params[:id])
    end

    # get message from a thread based on a particular recipient
    def by_recipient
        render :json => [Message.find(params[:id])] + Message.where(parent: params[:id]).where(recipient: params[:user_id])
    end

    private
    def message_params
      params.require(:thread).permit()
    end

    private
    def record_not_found
      render status: :bad_request, 
        json: {
          status: :bad_request
        }
    end
end
