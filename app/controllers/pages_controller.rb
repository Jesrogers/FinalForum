class PagesController < ApplicationController
  def home
    news_forum = Forum.find_by(title: "Company News")

    if news_forum
      @news_posts = Forum.find_by(title: "Company News").forum_threads
    end

    render 'home', layout: 'home'
  end

  def latest
    @latest_threads = ForumThread.limit(20).order("updated_at DESC")
  end
end
