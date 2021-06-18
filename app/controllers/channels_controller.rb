class ChannelsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    load_and_authorize_resource

    def index
    end

    def show
        add_breadcrumb("Channels", "/forums")
        add_breadcrumb(@channel.name)
    end

    def new
    end

    def create
        if @channel.save
            redirect_to '/forums'
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

    def channel_params
        params.require(:channel).permit(:name, :position)
    end
end
