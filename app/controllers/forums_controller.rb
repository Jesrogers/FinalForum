class ForumsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :find_channels, only: [:new, :edit, :create, :update]
  load_and_authorize_resource except: [:show]

  def show
    @forum = Forum.find(params[:id])

    add_breadcrumb("Forums", "/forums")
    add_breadcrumb(@forum.title)
  end

  def new
    @selected_channel = Channel.find(params[:channel])
  end

  def create
    if @forum.save
      redirect_to "/forums"
    else
      @selected_channel = Channel.find(params[:forum][:channel_id])
      render :new
    end
  end

  def edit
    @selected_channel = Forum.find(params[:id]).channel
  end

  def update
    @selected_channel = Forum.find(params[:id]).channel

    if @forum.update(forum_params)
      redirect_to "/forums"
    else
      render :edit
    end
  end

  def destroy
    @forum.destroy
    redirect_to "/forums"
  end

  private

  def forum_params
    params.require(:forum).permit(:title, :description, :channel_id, :position, :locked)
  end

  def find_channels
    @channel_options = Channel.all.map { |channel| [channel.name, channel.id] }
  end
end
