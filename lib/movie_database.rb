require 'active_record'
require 'sqlite3'
require 'yaml'



class MovieDatabase
  def self.setup(env = 'development')
    # Load database configuration
    
    # Ensure db directory exists
    FileUtils.mkdir_p('db') unless File.directory?('db')

    # establish connection to the database
  end
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

    # Ensure db directory exists
    FileUtils.mkdir_p('db') unless File.directory?('db')

    # Establish connection to the database
    ActiveRecord::Base.establish_connection(db_config)
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

end 