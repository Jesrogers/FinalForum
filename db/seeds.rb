# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(username: "Bill", email: "test@gmail.com", password: "testtest", password_confirmation: "testtest")
User.create!(username: "Fred", email: "testy@gmail.com", password: "testtest", password_confirmation: "testtest")

Channel.create(name: 'Employees', position: 1)

Forum.create(title: "General Discussion", description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vehicula, velit porttitor accumsan tincidunt, arcu mi viverra augue, ac dignissim lacus lorem vitae orci', position: 1, locked: false, channel_id: 1)
Forum.create(title: "Marketplace", description: 'Suspendisse sollicitudin imperdiet velit, in eleifend sapien. Donec tempor faucibus magna sed aliquam. Mauris efficitur magna at pulvinar malesuada. Ut a ex vel dui vestibulum dignissim', position: 1, locked: false, channel_id: 1)
Forum.create(title: "Finalsite Fitness", description: 'Donec mi magna, consequat vel lectus vel, aliquam venenatis eros. Ut ut venenatis dolor. Duis vel magna vel risus gravida ullamcorper non ut est', position: 1, locked: false, channel_id: 1)

ForumThread.create(title: "This company is great!", body: "Leverage agile frameworks to provide a robust synopsis for high level overviews. Iterative approaches to corporate strategy foster collaborative thinking to further the overall value proposition. Organically grow the holistic world view of disruptive innovation via workplace diversity and empowerment.", replies: 0, last_post: nil,forum_id: 1, author_id: 1)
ForumThread.create(title: "Wow, does anyone else...", body: "Suspendisse sollicitudin imperdiet velit, in eleifend sapien", replies: 0, last_post: nil,forum_id: 1, author_id: 1)
ForumThread.create(title: "Who has exciting plans for the weekend?", body: "Suspendisse sollicitudin imperdiet velit, in eleifend sapien", replies: 0, last_post: nil,forum_id: 1, author_id: 2)
ForumThread.create(title: "The weather is getting crazy hot", body: "Suspendisse sollicitudin imperdiet velit, in eleifend sapien", replies: 0, last_post: nil,forum_id: 1, author_id: 1)