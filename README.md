# README

## NYT Best Sellers API
<!-- [LiveSite](www.site.come) -->

**Overview**
NYT Best Sellers API is a lightweight Rails application that displays valid JSON of NYT Best selling books by author and/or publisher. The application does not have a frontend and is purely interacted with through the URL query string. It requests and consumes from external API, New York Times Books API.


**Technologies**
Rails 5.2.6
Ruby 2.7.1

## Setup
**Install gems required by application:** 

    bundle

**Next, execute the database migrations/schema setup:**

	bundle exec rake db:setup

## Start the app

    rails server

## Search by Author and/or Publisher

The client will search the name of a chosen author and/or publisher within the query string in key-value pairs and with '&' as a parameter seperator. Examples below.

**By author:**
    /fetch_data?author=Stephen King
**By publisher:**
    /fetch_data?publisher=DC Comics
**By author & publisher:**
    /fetch_data?author=Stephen King&publisher=DC Comics
    

**Sort data**
The client is able to sort by title, author, publisher & description by utilizing the 'sort' key within the query string. Examples below.

    /fetch_data?author=Stephen King&sort=title


    /fetch_data?author=Roxane Gay&sort=description


**In-progress**

Update RSPECs

Deploy to Heroku

Implement authentication
