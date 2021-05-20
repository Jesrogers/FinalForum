class ForumsController < ApplicationController
    before_action :set_forum, only: [:show, :edit, :update, :destroy]
    before_action :find_channels, only: [:new, :edit]

    def show
    end

    def new
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

    def edit
    end

    def update
        if @forum.update(forum_params)
            redirect_to '/forums'
        else
            render :edit
        end
    end

    def destroy
        @forum.destroy
        redirect_to '/forums'
    end

    private

    def forum_params
        params.require(:forum).permit(:title, :description, :channel_id, :position, :locked)
    end

    def set_forum
        @forum = Forum.find(params[:id])
    end

    def find_channels
        @channel_options = Channel.all.map { |channel| [channel.name, channel.id] }
    end
end
