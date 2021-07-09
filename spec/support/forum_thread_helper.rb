module ForumThreadHelpers
    def go_to_forum_thread(thread)
      visit root_path
      click_link "Forums"
      click_link(href: forum_path(thread.forum), class: "forum-card__link")
      click_link(href: forum_thread_path(thread))
    end
end
  
RSpec.configure do |config|
    config.include ForumThreadHelpers, type: :system
end
  