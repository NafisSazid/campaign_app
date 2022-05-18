# Get Started

Seedrs mini backend

## Setup:

* Clone/download the repo
* Run `bundle install` to install the required gems. If install fails on mac/linux machine, please delete gemfile.lock and try again.
* Run following
```
rails db:create
rails db:migrate
rails db:seed
```

* Start server: `rails s`

## API endpoints

* **Retrieve Campaigns:** GET `http://localhost:3000/api/v1/campaigns`  
This will retrieve all the campaigns. User can also filter the campaigns by providing query params. 
E.g: `.../api/v1/campaigns?sector=Business` will filter the result by showing only
Business sector campaigns.  
Available filter params: 
  * sector
  * amount - filter campaigns whose target_amount >= given amount
  * investor_number - filter by number of investors in the campaign


* **Create Investment in a Campaign:** POST `http://localhost:3000/api/v1/investments`  
Post request with body:  
  * investor_name - required field
  * amount - required field - amount to be invested
  * campaign_id - required field - id of selected campaign


* The apis are accessible through any REST client, e.g: Postman, CURL commands on cli.  
If you use Postman, I have added an api collection [export file](https://github.com/amit-khan/seedrs_app/blob/master/Seedrs.postman_collection.json) in the repo.
You can simply import this file from Postman app and run the apis.

## Tests - Rspec

* `rake db:prepare`
* Run all specs: `bundle exec rspec`


### How would I modify data model to filter the campaigns by properties like- sector, size...

To filter by properties like sector, amount, name etc. I have implemented filter scope in campaign api.
The scope will be given through query params with the request, based on that param, I have run db query to filter the result.  

Filter by number of investors: On my present implementation, I am saving investor_name in investments table. If we assume this field as a unique username, the
filter implementation will satisfy the need (as I have counted the number of investments with unique investor_name). However, for better approach, we will have 
to introduce User model to uniquely identify users. Investment table will link to a user id as investor. Afterwards, to filter by unique users(investors), we will 
run query joining three of those tables.
