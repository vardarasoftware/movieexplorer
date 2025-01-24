require 'active_record'
require 'sqlite3'
require 'yaml'
require 'fileutils'
require './models/movie'

class MovieDatabase
  # Establishes a connection to the SQLite database based on the specified environment
  #
  # @param env [String] The database environment to connect to (default: 'development')
  # @return [ActiveRecord::Base] The established database connection
  #
  # This method:
  # 1. Loads the database configuration from config/database.yml
  # 2. Creates the 'db' directory if it doesn't exist
  # 3. Establishes an ActiveRecord connection using the configuration
  def self.establish_connection(env = 'development')
    # Load database configuration from YAML file
    db_config = YAML.load_file('/home/heesha/Projects/movieexplorer/config/database.yml')
    # Ensure db directory exists
    FileUtils.mkdir_p('db') unless File.directory?('db')

    # Establish connection to the database
    ActiveRecord::Base.establish_connection(db_config['development'])
  end

  # Migrates the database to create the movies table
  #
  # @return [void]
  #
  # This method:
  # 1. Uses ActiveRecord to create the movies table
  # 2. Defines columns for title, year, imdb_id, poster
  # 3. Adds timestamps for created_at and updated_at
  # 4. Forces recreation of the table if it already exists
  def self.migrate
    ActiveRecord::Base.connection.create_table :movies, force: true do |t|
      t.string :title
      t.string :year
      t.string :imdb_id
      t.string :poster
      t.timestamps
    end
  end

  # Rolls back the database migration by dropping the movies table
  #
  # @return [void]
  #
  # This method:
  # 1. Drops the movies table from the database
  # 2. Removes all existing movie records
  def self.rollback
    # TODO: Implement rollback logic here
  end

  def save(movie_data)
    movie = Movie.new(
      title: movie_data['Title'],
      year: movie_data['Year'],
      imdb_id: movie_data['imdbID'],
      poster: movie_data['Poster']
    )
    movie.save
  end
end
