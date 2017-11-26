# Chat

This project was made as final project of the course Software Quality.
A private chat room thought to be used by an enterprise for their internal communication.

## Functionality

* Autentication with Devise.
* Registration is only with an email the enterprise email server (@yourdomain.com by default).
* Online/Offline indicator inside chat room.
* Private chat rooms, either personal or group.
* All the messages are encrypted in the server-side.
* Admin panel Rails Admin.


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

```
Ruby 2.3.1p112

Rails 5.1.3
```

### Installing


First
```
bundle install
```
Then
```
rake db:create

rake db:reset db:migrate
```

## Authors

* **Ilya Bodrov-Krukowski** - *Initial work* - [Repo](https://github.com/bodrovis/Sitepoint-source/tree/master/Chat_with_ActionCable_and_Devise) extracted from * [this post](https://www.sitepoint.com/create-a-chat-app-with-rails-5-actioncable-and-devise/)
* **Chiappero Federico** - *Improve and expand project*