# Name

M-chat

## Description

<!-- M-chat is an in-house chat application with profile function. -->

## DEMO

"hoge"の魅力が直感的に伝えわるデモ動画や図解を載せる

## Features

- Users can sign-up, sign-in and sign-out to identify each user.
  Users can edit their profile information and upload a profile photo in order to recognize each other. (devise_controller)
- Users can send a message in an exclusive chatroom, which means other users can't see it. (chat_controller, messages_controller)
- Users can search for other users with the search function. (user_controller)
  4 The texting system has a basic but necessary such as nil check(users can't send a blank message) and distinction the sender of each message. (chat_room_channels)
- The pages are responsive to fit a variety of screen sizes. (scss in assets)

## Usage

- Sign-up to M-chat by entering your information.
- Search for other users and create a chat room.
- You can type your message in the chat box and send it by pressing the send button.
- You can also check other user's profiles, edit your own profile and sign-out.

## Main tool for implement

- ruby-on-rails
  implementing a fundamental function by ruby
- devise
  implementing sign-in, sign-up and sign-out function
- action-cable
  implementing realtime chat application

## Requirement

- devise
  implementing sign-in, sign-up and sign-out function

- rails-i18n and devise-i18n
  changing the language to Japanese
- bootstrap(4.5.0), jquery-rails, font-awesome-sass(5.13.0)
  providing a user-friendly design

- carrierwave(2.0), mini_magick
  implementing picture uploading function for user profiles

## How does Action Cable work

Action Cable implements realtime chat app

## Installation

These requirements are installed by gemfile on ruby-on-rails

## DateBase

- User
  id: integer
  name: string
  password: string
  self_introduction: string
  img_name: string
- chat_room
  id: integer
- chat_room_user
  id: integer
  chat_room_id: integer
  user_id: user
- chat_message
  id: integer
  chat_room_id: integer
  user_id: integer
  message: string

## the hardest parts

- Implementing realtime chat
  I struggled to find a fitting Japanese reference to learn how to build a realtime chat app, as many of the references I found online were made using an older version of ruby on rails.
  I was able to find an English reference video which is available on Youtube and that has helped me a lot.
- Making application responsive to a certain extent.
  I still find making a responsive website quite tricky at my current level. However, with the help of Bootstrap and Flexbox, I was able to make the page responsive to an extent.]

- Recognizing the sender of each message.
  Making the messages distinguishable through the use of colour requires javascript which I have not studied so much yet. However I was able to do this using the video I mention above.
- recreating chat app from matching app
  I had to edit the content of the database and controller of the matching app reference in order to make the chat app.

## Author

- Ariki Hamano
