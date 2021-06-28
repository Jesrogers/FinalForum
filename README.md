# FinalForum

Mock forum application for my company that allows for users to interact with one another via threads & replies.

Deployed at: [https://finalforum.herokuapp.com).

## Project Features

1. Account creation and login
2. Forum architecture:
   * Channels serve as "categories" that forums belong to
   * Forums act as containers for related threads
   * Threads are the topics that users can post
   * Users can reply to threads
3. Authorization:
   * Admins have full access to all forum components (CRUD actions on channels, forums, threads, and replies)
   * Admins can reposition channels and forums to display them in their desired order
   * Admins can lock forums and threads, preventing regular users from creating / editing affected threads & replies.
   * Admins can pin threads, causing them to appear first in the list
   * Regular users can create threads and replies in unlocked forums / threads
   * Regular users can only edit their own threads and replies
4. Each user has their own profile page that aggregates data related to them (has a modifiable "biography" section too)
5. Other things of note:
   * Mobile friendly
   * "Pretty" URLs for resources
   * Dynamic breadcrumb menu on relevant pages
   * Rich-text editing in certain areas thanks to CKEditor
   
## Gems
* `Devise` for user registrations and sessions
* `Rolify` to create an administrator role
* `CanCanCan` for role-based authorization
* `CKEditor` allows for a wider range of text-editing capibilities in certain areas
* `Font_awesome5_rails` brings in icons
* `Gravatar_image_tag` generates user avatars
* `Friendly_id` to make URL slugs human-friendly

## Running Locally
1. Clone the repository
2. Run `bundle` and `npm install`
3. Setup database (will need PostgreSQL installed) by running `rails db:setup`
4. Start the server via `rails s`

## Video Demo and Screenshots

### Video tour
[![video demo](https://i.imgur.com/yAguM9W.png)](https://www.youtube.com/watch?v=3TK8UvuGRW0)

### Channels section

[![channels section](https://i.imgur.com/WTaW3Ha.png)](https://i.imgur.com/WTaW3Ha.png)

### Inside a forum

[![inside a forum](https://i.imgur.com/gtE27JY.png)](https://i.imgur.com/gtE27JY.png)

### A thread with replies

[![thread with replies](https://i.imgur.com/zaZifys.png)](https://i.imgur.com/zaZifys.png)

### User profile page

[![user profile page](https://i.imgur.com/ImxMYLL.png)](https://i.imgur.com/ImxMYLL.png)