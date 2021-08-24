# README

A project for taking the hand on Ruby on Rails.

To test the project, run:
`docker-compose up`

You can then run 
- `docker exec kicklox_web_1 rails db:setup` to setup the migration serie
- `docker exec kicklox_web_1 rails test` to execute the tests serie
- `docker exec kicklox_web_1 rails messages:prune` to execute the archiving job

Either of thoses commands can be shorten to `rails ...` if you source the `.fish_config`
in the root directory with the fish shell, providing a shortcut to `docker exec kicklox_web_1 rails`.
