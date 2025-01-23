require 'active_record'
  # Schema for the movies table
  # Columns:
  # - title: string (movie title)
  # - year: string (year of release)
  # - imdb_id: string (unique IMDB identifier)
  # - poster: string (URL or path to movie poster)
  # - created_at: timestamp (when record was created)
  # - updated_at: timestamp (when record was last updated)

class Movie < ActiveRecord::Base
  ## this is the model for the movie table
  ## in order to interact with the database, you need to create a migration file    
  ## and then create a model file
  ## the migration file is located in the db/migrate folder
  ## the model file is located in the app/models folder
end
