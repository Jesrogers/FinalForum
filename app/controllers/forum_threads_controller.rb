class ForumThreadsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_forum, only: [:new, :create]
  load_and_authorize_resource except: [:new, :create]

  def new
    @forum_thread = @forum.forum_threads.build
    authorize! :create, @forum_thread

    add_forum_thread_breadcrumbs
  end

  def create
    @forum_thread = @forum.forum_threads.build(forum_thread_params)
    @forum_thread.author_id = current_user.id
    authorize! :create, @forum_thread

    if @forum_thread.save
      redirect_to forum_thread_path(@forum_thread)
    else
      add_forum_thread_breadcrumbs
      render :new
    end
  end

  def show
    @forum_thread = ForumThread.find(params[:id])

    add_forum_thread_breadcrumbs
  end

  def edit
    @forum_thread = ForumThread.find(params[:id])
    add_forum_thread_breadcrumbs
  end

  def update
    if @forum_thread.update(forum_thread_params)
      redirect_to forum_thread_path(@forum_thread)
    else
      add_forum_thread_breadcrumbs
      render :edit
    end
  end

  def destroy
    @forum_thread.destroy
    redirect_to forum_path(@forum_thread.forum), notice: "Thread deleted."
  end

  private

  def set_forum
    @forum = Forum.find(params[:forum_id])
  end

  def forum_thread_params
    if helpers.user_has_role?(:admin)
      params.require(:forum_thread).permit(:title, :body, :pinned, :locked)
    else
      params.require(:forum_thread).permit(:title, :body)
    end
  end

  def add_forum_thread_breadcrumbs
    add_breadcrumb("Forums", "/forums")
    add_breadcrumb(@forum_thread.forum.title, forum_path(@forum_thread.forum))
    add_breadcrumb(@forum_thread.title)
  end
end
