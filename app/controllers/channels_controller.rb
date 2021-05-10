class ChannelsController < ApplicationController
    def index
        @channels = Channel.all
    end

    def new
        @channel = Channel.new
    end

    def create
        @channel = Channel.new(channel_params)

        if @channel.save
            redirect_to channels_path
        else
            render :new
        end
    end

    def edit
        @channel = Channel.find(params[:id])
    end

    def update
        @channel = Channel.find(params[:id])

        if @channel.update(channel_params)
            redirect_to channels_path
        else
            render :edit
        end
    end

    def destroy
         @channel = Channel.find(params[:id])
         @channel.destroy
         redirect_to channels_path
    end

    private 

    def channel_params
        params.require(:channel).permit(:name, :position)
    end
end
