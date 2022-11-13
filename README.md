# README

## Endpoint: `localhost:3000`

## Versions Used

![Ruby Version](https://img.shields.io/badge/Ruby-2.7.2-red)
![Rails Version](https://img.shields.io/badge/Rails-7.0.2-red)

## Setup

postgesql credentials for: development and production
```ruby
username: rails
password: rails
```

config/environment.rb
```ruby
Rails.env="production"
```

run
```bash
bundle install
rails db:create db:migrate
```

