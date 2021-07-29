class ThreadsController < ApplicationController
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
        render :json => Message.where(parent: params[:id]).where(recipient: params[:user_id])
    end
end
