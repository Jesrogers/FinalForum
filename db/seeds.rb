# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Passwords have been updated via the Rails console after seeding (except for test user)
Bill = User.create!(username: "Billinator", email: "billinator@example.com", password: "testtest",
                    password_confirmation: "testtest", last_sign_in_at: DateTime.now)
User.create!(username: "Freddy", email: "freddy@example.com", password: "testtest", password_confirmation: "testtest",
             last_sign_in_at: DateTime.now)
User.create!(username: "Coolguyjohn", email: "coolguyjohn@example.com", password: "testtest",
             password_confirmation: "testtest", last_sign_in_at: DateTime.now)
User.create!(username: "Visitor", email: "visitor@example.com", password: "testing",
             password_confirmation: "testing", last_sign_in_at: DateTime.now)

Channel.create(name: "Employees", position: 2)
Channel.create(name: "Departments", position: 3)
Channel.create(name: "News", position: 1)

Forum.create(channel_id: 1, title: "General Discussion", locked: false,
             description: "Talk about, you know... general stuff", position: 0)
Forum.create(channel_id: 1, title: "Marketplace", locked: false,
             description: "Buy, sell, or trade items to your coworkers", position: 1)
Forum.create(channel_id: 1, title: "Finalsite Fitness", locked: false,
             description: "Have fun while staying in shape", position: 1)
Forum.create(channel_id: 2, title: "Support", locked: false,
             description: "Who you gonna call? Support!", position: 1)
Forum.create(channel_id: 2, title: "Deployment", locked: false,
             description: "Site-building construction zone", position: 1)
Forum.create(channel_id: 2, title: "Development", locked: false,
             description: "Software doesn't grow on trees you know", position: 1)
Forum.create(channel_id: 3, title: "Company News", locked: true,
             description: "News & Announcements", position: 1)

ForumThread.create(forum_id: 1, author_id: 1, locked: false, pinned: false, title: "This forum is great!",
                   body: "<p>Wow, I love this forum! If I had more to say, I'd include it below. Instead, here is some 'corporate ipsum'.</p><p>Leverage agile frameworks to provide a robust synopsis for high level overviews. Iterative approaches to corporate strategy foster collaborative thinking to further the overall value proposition. Organically grow the holistic world view of disruptive innovation via workplace diversity and empowerment. </p>", created_at: "2021-06-02 12:22:48.662059000 +0000", updated_at: "2021-06-02 12:22:48.662059000 +0000")
ForumThread.create(forum_id: 1, author_id: 3, locked: false, pinned: false, title: "What is your favorite food?",
                   body: "<p> I'm a big fan of dark chocolate.<p>", created_at: "2021-03-05 12:22:48.662059000 +0000", updated_at: "2021-03-05 12:22:48.662059000 +0000")
ForumThread.create(forum_id: 1, author_id: 2, locked: false, pinned: false,
                   title: "Who has exciting plans for the weekend?", body: "<p>I might go up to Cape Cod. I just hope it doesn't get too hot!</p>", created_at: "2019-08-05 12:22:48.662059000 +0000", updated_at: "2019-08-05 12:22:48.662059000 +0000")
ForumThread.create(forum_id: 1, author_id: 1, locked: false, pinned: false, title: "The weather is getting crazy hot",
                   body: "<p>I'm in Cape Cod right now and it's so hot. I definititely don't think anyone should come here right now. </p>", created_at: "2020-07-05 12:22:48.662059000 +0000", updated_at: "2020-07-05 12:22:48.662059000 +0000")
ForumThread.create(forum_id: 1, author_id: 1, locked: true, pinned: true, title: "Important Message!",
                   body: "<p>This isn't really an important message. I just wanted to to pin this post to feel special.</p>", created_at: "2021-05-19 05:24:48.662059000 +0000", updated_at: "2021-05-19 05:24:48.662059000 +0000")
ForumThread.create(forum_id: 2, author_id: 3, locked: false, pinned: false, title: "I'm selling all the best stuff!",
                   body: "<p>Who wants to buy it?</p>", created_at: "2020-03-05 06:41:42.662059000 +0000", updated_at: "2021-06-09 19:13:21.662059000 +0000")
ForumThread.create(forum_id: 3, author_id: 2, locked: false, pinned: false, title: "Post your fitness goals here",
                   body: "<p>My goal is to run a marathon!</p>", created_at: "2020-03-05 06:41:42.662059000 +0000", updated_at: "2021-06-09 19:13:21.662059000 +0000")
ForumThread.create(forum_id: 4, author_id: 1, locked: false, pinned: true, title: "Trends in Support",
                   body: "<p>Great job team, we just solved a million tickets in a single day!</p>", created_at: "2020-03-05 06:41:42.662059000 +0000", updated_at: "2021-06-09 19:13:21.662059000 +0000")
ForumThread.create(forum_id: 5, author_id: 1, locked: false, pinned: true, title: "Deployment Discussion",
                   body: "<p>We're almost at 5000 sites launched, keep it up!</p>", created_at: "2020-03-05 06:41:42.662059000 +0000", updated_at: "2021-06-09 19:13:21.662059000 +0000")
ForumThread.create(forum_id: 6, author_id: 1, locked: false, pinned: true, title: "Development News",
                   body: "<p>We should invent a new JS framework. How does FinalFramework sound?</p>", created_at: "2020-03-05 06:41:42.662059000 +0000", updated_at: "2021-06-09 19:13:21.662059000 +0000")
ForumThread.create(forum_id: 7, author_id: 1, locked: false, pinned: true, title: "Welcome!",
                   body: "<p>Thanks for stopping by! Feel free to browse and post at your leisure.&nbsp;</p><p>Please abide by our content policy of &quot;being nice&quot;. Send me a message if you need anything or have any feature requests!</p>", created_at: "2020-06-17 09:4.:21.662059000 +0000", updated_at: "2020-06-17 09:4.:21.662059000 +0000")

ForumReply.create(forum_thread_id: 1, author_id: 2,
                  body: "<p>I like it a lot too. I'm going to include corporate ipsum with bullet points.</p> <p>Collaboratively administrate empowered markets via plug-and-play networks.</p> <ol><li>Dynamically procrastinate B2C users</li><li>Dramatically visualize customers</li><li>Efficiently unleash cross-media information</li></ol><p>Completely synergize resource taxing relationships via premier niche markets. Professionally cultivate one-to-one customer service with robust ideas. Dynamically innovate resource-leveling customer service for state of the art customer service.</p>", created_at: "2021-06-02 13:18:48.662059000 +0000", updated_at: "2021-06-02 13:18:48.662059000 +0000")
ForumReply.create(forum_thread_id: 1, author_id: 3,
                  body: "<p>What are you guys <strong>talking</strong> about? I'm so confused...</p>", created_at: "2021-06-04 14:03:48.662059000 +0000", updated_at: "2021-06-04 14:03:48.662059000 +0000")
ForumReply.create(forum_thread_id: 1, author_id: 1,
                  body: "<p>What's wrong CoolGuyJohn? This is how we normally communicate.</p>", created_at: "2021-06-08 12:49:48.662059000 +0000", updated_at: "2021-06-08 12:49:48.662059000 +0000")

Bill.add_role(:admin)
