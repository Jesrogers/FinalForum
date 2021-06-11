class ForumThreadsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_forum, only: [:new, :create]
    before_action :set_forum_thread, only: [:show, :edit, :update, :destroy]
    before_action :thread_authorize_check, only: [:edit, :update, :destroy]

    def new
        @forum_thread = ForumThread.new
    end

    def create
        @forum_thread = @forum.forum_threads.build(forum_thread_params)
        @forum_thread.author_id = current_user.id

        if @forum_thread.save
            redirect_to forum_thread_path(@forum_thread)
        else
            render :new
        end
    end

    def show
    end

    def edit
    end

    def update
        if @forum_thread.update(forum_thread_params)
            redirect_to forum_thread_path(@forum_thread)
        else
            render :edit
        end
    end

    def destroy
        @forum_thread.destroy
        redirect_to forum_path(@forum_thread.forum)
    end

    private

    def set_forum
        @forum = Forum.find(parama[:forum_id])
    end

    def set_forum_thread
        @forum_thread = ForumThread.find(params[:id])
    end

    def forum_thread_params
        params.require(:forum_thread).permit(:title, :body)
    end
end