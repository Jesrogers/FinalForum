class ForumsController < ApplicationController
    before_action :authenticate_user!, except: [:show]
    before_action :find_channels, only: [:new, :edit]
    load_and_authorize_resource except: [:show]

    def show
        @forum = Forum.find(params[:id])
    end

    def new
    end

    def create
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

    def find_channels
        @channel_options = Channel.all.map { |channel| [channel.name, channel.id] }
    end
end
