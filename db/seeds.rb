# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Channel.create(name: 'Employees', position: 1)

Forum.create(title: "General Discussion", description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vehicula, velit porttitor accumsan tincidunt, arcu mi viverra augue, ac dignissim lacus lorem vitae orci', position: 1, locked: false, channel_id: 1)
Forum.create(title: "Marketplace", description: 'Suspendisse sollicitudin imperdiet velit, in eleifend sapien. Donec tempor faucibus magna sed aliquam. Mauris efficitur magna at pulvinar malesuada. Ut a ex vel dui vestibulum dignissim', position: 1, locked: false, channel_id: 1)
Forum.create(title: "Finalsite Fitness", description: 'Donec mi magna, consequat vel lectus vel, aliquam venenatis eros. Ut ut venenatis dolor. Duis vel magna vel risus gravida ullamcorper non ut est', position: 1, locked: false, channel_id: 1)