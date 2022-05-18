# README

Seedrs mini backend

## Setup:

* Run `bundle install` to install the required gems. If install fails on mac/linux machine, please delete gemfile.lock and try again.
* Run following
```
rails db:create
rails db:migrate
rails db:seed
```

* Start server: `rails s`

## API endpoints

* Campaigns list: GET `http://localhost:3000/api/v1/campaigns`  
This will retrieve all the campaigns. User can also filter the campaigns by providing query params. 
E.g: `http://localhost:3000/api/v1/campaigns?sector=Business` will filter the result and only show
Business sector campaigns.  
Available filter params: 
  * sector
  * amount - filter campaigns whose target_amount > given amount
  * investor_number - filter by number of investors for a campaign


* Investment create: POST `http://localhost:3000/api/v1/campaigns/campaign_id/investments`  
Put id of selected campaign in place of `campaign_id`.  
Post request with body:  
  * investor_name - required field
  * amount - required field - amount to be invested


* The apis are accessible through any REST client, e.g: Postman, CURL commands on cli.

## Tests - Rspec

* `rake db:prepare`
* Run all specs: `bundle exec rspec`

