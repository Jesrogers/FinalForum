class PagesController < ApplicationController
  def home
    @news_posts = Forum.find_by(title: "Company News").forum_threads
    render 'home', layout: 'home'
  end

  def latest
    @latest_threads = ForumThread.limit(20).order("updated_at DESC")
  end
end
