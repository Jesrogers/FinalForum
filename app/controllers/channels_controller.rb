class ChannelsController < ApplicationController
    before_action :set_channel, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]

    def index
        @channels = Channel.all
    end

    def show
    end

    def new
        @channel = Channel.new
    end

    def create
        @channel = Channel.new(channel_params)

        if @channel.save
            redirect_to '/forums', notice: "Channel created."
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @channel.update(channel_params)
            redirect_to '/forums', notice: "Channel updated."
        else
            render :edit
        end
    end

    def destroy
         @channel.destroy
         redirect_to '/forums', notice: "Channel deleted."
    end

    private 

    def set_channel
        @channel = Channel.find(params[:id])
    end

    def channel_params
        params.require(:channel).permit(:name, :position)
    end
end
