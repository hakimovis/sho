# README

Clone repo, run `bundle install`, roll migrations, blah blah blah...
Run sidekiq:

```
bundle exec sidekiq -C config/sidekiq.yml
```

Run server:
```
bundle exec unicorn_rails -c config/unicorn.rb -E production
```