# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Bill = User.create!(username: "Billinator", email: "test@gmail.com", password: "testtest", password_confirmation: "testtest", slug: "billinator", last_sign_in_at: DateTime.now)
User.create!(username: "Freddy", email: "testy@gmail.com", password: "testtest", password_confirmation: "testtest", slug: "freddy", last_sign_in_at: DateTime.now)
User.create!(username: "Coolguyjohn", email: "testyy@gmail.com", password: "testtest", password_confirmation: "testtest", slug: "coolguyjohn", last_sign_in_at: DateTime.now)

Channel.create(name: 'Employees', position: 1)
Channel.create(name: 'Departments', position: 1)

Forum.create(channel_id: 1, title: "General Discussion", locked: false, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vehicula', position: 1)
Forum.create(channel_id: 1, title: "Marketplace", locked: false, description: 'Suspendisse sollicitudin imperdiet velit, in eleifend sapien', position: 1)
Forum.create(channel_id: 1, title: "Finalsite Fitness", locked: true, description: 'Donec mi magna, consequat vel lectus vel, aliquam venenatis eros. Ut ut venenatis dolor', position: 1)
Forum.create(channel_id: 2, title: "Support", locked: false, description: 'Lectus magna fringilla urna porttitor rhoncus dolor purus non enim. Diam in arcu cursus euismod', position: 1)
Forum.create(channel_id: 2, title: "Deployment", locked: false, description: 'Ultricies mi quis hendrerit dolor. Urna porttitor rhoncus dolor purus non enim praesent elementum facilisis', position: 1)

ForumThread.create(forum_id: 1, author_id: 1, locked: false, pinned: false, title: "This company is great!", body: "<p>Leverage agile frameworks to provide a robust synopsis for high level overviews. Iterative approaches to corporate strategy foster collaborative thinking to further the overall value proposition. Organically grow the holistic world view of disruptive innovation via workplace diversity and empowerment. </p>", created_at: "2021-06-02 12:22:48.662059000 +0000", updated_at: "2021-06-02 12:22:48.662059000 +0000")
ForumThread.create(forum_id: 1, author_id: 3, locked: false, pinned: false, title: "Wow, does anyone else...", body: "<p>Bring to the table win-win survival strategies to ensure proactive domination. At the end of the day, going forward, a new normal that has evolved from generation X is on the runway heading towards a streamlined cloud solution. <p>", created_at: "2021-03-05 12:22:48.662059000 +0000", updated_at: "2021-03-05 12:22:48.662059000 +0000")
ForumThread.create(forum_id: 1, author_id: 2, locked: false, pinned: false, title: "Who has exciting plans for the weekend?", body: "<p>Capitalize on low hanging fruit to identify a ballpark value added activity to beta test. Override the digital divide with additional clickthroughs from DevOps. Nanotechnology immersion along the information highway will close the loop on focusing solely on the bottom line.</p>", created_at: "2019-08-05 12:22:48.662059000 +0000", updated_at: "2019-08-05 12:22:48.662059000 +0000")
ForumThread.create(forum_id: 1, author_id: 1, locked: false, pinned: false, title: "The weather is getting crazy hot", body: "<p>Suspendisse sollicitudin imperdiet velit, in eleifend sapien</p>", created_at: "2020-07-05 12:22:48.662059000 +0000", updated_at: "2020-07-05 12:22:48.662059000 +0000")
ForumThread.create(forum_id: 1, author_id: 1, locked: true, pinned: true, title: "Important Message!", body: "<p>This isn't really an important message. I just wanted to to pin this post to feel special.</p>", created_at: "2021-05-19 05:24:48.662059000 +0000", updated_at: "2021-05-19 05:24:48.662059000 +0000")
ForumThread.create(forum_id: 2, author_id: 3, locked: false, pinned: false, title: "I'm selling all the best stuff!", body: "<p>Who wants to buy it?</p>", created_at: "2020-03-05 06:41:42.662059000 +0000", updated_at: "2021-06-09 19:13:21.662059000 +0000")

ForumReply.create(forum_thread_id: 1, author_id: 2, body: "<p>Collaboratively administrate empowered markets via plug-and-play networks.</p> <ol><li>Dynamically procrastinate B2C users</li><li>Dramatically visualize customers</li><li>Efficiently unleash cross-media information</li></ol><p>Completely synergize resource taxing relationships via premier niche markets. Professionally cultivate one-to-one customer service with robust ideas. Dynamically innovate resource-leveling customer service for state of the art customer service.</p>", created_at: "2021-06-02 13:18:48.662059000 +0000", updated_at: "2021-06-02 13:18:48.662059000 +0000")
ForumReply.create(forum_thread_id: 1, author_id: 3, body: "<p>What are you guys <strong>talking</strong> about? I'm so confused...</p>", created_at: "2021-06-04 14:03:48.662059000 +0000", updated_at: "2021-06-04 14:03:48.662059000 +0000")
ForumReply.create(forum_thread_id: 1, author_id: 1, body: "<p>Interactively procrastinate high-payoff content without backward-compatible data. Quickly cultivate optimal processes and tactical architectures. Completely iterate covalent strategic theme areas via accurate e-markets.</p><p>Globally incubate standards compliant channels before scalable benefits. Quickly disseminate superior deliverables whereas web-enabled applications. Quickly drive clicks-and-mortar catalysts for change before vertical architectures.</p>", created_at: "2021-06-08 12:49:48.662059000 +0000", updated_at: "2021-06-08 12:49:48.662059000 +0000")

Bill.add_role(:admin)