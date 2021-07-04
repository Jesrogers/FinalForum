module ForumHelpers
  def go_to_forum(forum)
    visit root_path
    click_link "Forums"
    click_link(href: forum_path(forum), class: "forum-card__link")
  end
end

RSpec.configure do |config|
  config.include ForumHelpers, type: :system
end
