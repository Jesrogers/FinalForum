class ForumsController < ApplicationController
    def show
        @forum = Forum.find(params[:id])
    end

    def new
        @channel_options = Channel.all.map { |channel| [channel.name, channel.id] }
        @forum = Forum.new
    end

    def create
        @forum = Forum.new(forum_params)

        if @forum.save
            redirect_to '/forums'
        else
            render :new
        end
    end

    private

    def forum_params
        params.require(:forum).permit(:title, :description, :channel_id, :order, :locked)
    end
end
