# Getting Started with Tando Taco Server

## Environment Setup for Tandem Taco Client

This project is the server side of Tandem Taco.

Cors is already set up for the backend to communicate to the client through HTTP request.

Ruby version:

```
3.0.0
```

Rails version:

```
7.0.4
```

To install the packages for this project, run the command:

```
bundle install
```

#### Postgresql

This project uses the database service Posgresql. Here is a link to a guide that will help you install Postgresql on your Mac: https://wiki.postgresql.org/wiki/Homebrew

After installing pstgres, make sure to edit the `database.yaml` file in the configuration folder to match the username and password of your Postgres user that you create after setting up Postgresql.

## Installing Meilisearch

To help with creating a seamless search experience, I used a search engine called Meilisearch. To use this project, you have to install it on your local machine using homebrew on Mac:

#### Update brew and install Meilisearch

In your terminal, run the command:

`brew update && brew install meilisearch`

After it is installed, get the Meilisearch server up and running by typing this command in your termal:

`meilisearch`

After running the command, you should see Meilisearch start up in the terminal window. After this everything thing is good to go. Make sure to not close the terminal window. Leave it running in the background:

<img src="./app/assets/images/meilisearch.png"  style="width: 30rem;">

## Creating and Seeding Database

After the Meilisearch instance has started, you can now create the database and seed it with data by running the command:

```
rails db:reset
```

After the databse is seeded with data, you can now start the rails server to accept request from the client. Run the command:

```
rails s
```

## Tech Stack

Rails <br/>
Postgres <br/>
Meilisearch
