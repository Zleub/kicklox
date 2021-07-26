class ThreadsController < ApplicationController
    def index
        render :json => Message.where.not(parent: nil).distinct.pluck(:parent_id)
    end

    def show
        render :json => [Message.find(params[:id])] + Message.where(parent: params[:id])
    end
end
