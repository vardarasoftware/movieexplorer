require 'active_record'
require 'sqlite3'
require 'yaml'
require_relative '../models/movie'


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
    db_config = YAML.load_file('/home/rahul-choudhary/project/ruby assignment/movieexplorer/config/database.yml')
    
    # Ensure db directory exists
    FileUtils.mkdir_p('db') unless File.directory?('db')

    # Establish connection to the database
    ActiveRecord::Base.establish_connection(db_config["development"])
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
      t.string :rated
      t.string :released
      t.string :runtime
      t.string :genre
      t.string :director
      t.string :writer
      t.string :actors
      t.text :plot
      t.string :language
      t.string :country
      t.string :awards
      t.json :ratings    # JSON column for ratings
      t.string :metascore
      t.string :imdb_rating
      t.string :imdb_votes
      t.string :movie_type
      t.string :dvd
      t.string :box_office
      t.string :production
      t.string :website
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
    if ActiveRecord::Base.connection.table_exists?(:movies)
      # Drop the movies table
      ActiveRecord::Base.connection.drop_table :movies
    else
      puts "Movies table does not exist."
    end
  end

  def save_movie(movie_data)
    movie = Movie.create(
      title: movie_data['Title'],
      year: movie_data['Year'],
      imdb_id: movie_data['imdbID'],
      poster: movie_data['Poster'],
      rated: movie_data['Rated'],
      released: movie_data['Released'],
      runtime: movie_data['Runtime'],
      genre: movie_data['Genre'],
      director: movie_data['Director'],
      writer: movie_data['Writer'],
      actors: movie_data['Actors'],
      plot: movie_data['Plot'],
      language: movie_data['Language'],
      country: movie_data['Country'],
      awards: movie_data['Awards'],
      ratings: movie_data['Ratings'],
      metascore: movie_data['Metascore'],
      imdb_rating: movie_data['imdbRating'],
      imdb_votes: movie_data['imdbVotes'],
      movie_type: movie_data['Type'],
      dvd: movie_data['DVD'],
      box_office: movie_data['BoxOffice'],
      production: movie_data['Production'],
      website: movie_data['Website']
    )
    movie.save
    end

end 