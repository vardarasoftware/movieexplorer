require 'sqlite3'
require 'csv'
require './models/movie'
require './lib/movie_database'
require 'byebug'

# MovieImporter is responsible for importing movie data from a CSV file
#
# This class handles:
# - Reading movie data from movies_dump.csv
# - Parsing CSV data
# - Creating Movie records in the database
#
# @example
#   importer = MovieImporter.new
#   importer.import
class MovieImporter
  # Path to the CSV file containing movie data
  # CSV_FILE_PATH = '/home/rahul-choudhary/project/ruby assignment/movieexplorer/data/movies_dump.csv'

  def initialize
    MovieDatabase.establish_connection('development')
  end

  # Imports movies from the CSV file into the database
  #
  # @return [void]
  def import(file)
    Movie.destroy_all

    # Initialize counters for tracking successful and failed inserts
    success_count = 0
    failure_count = 0

    # TODO: Implement CSV import logic
    CSV.foreach(file, headers: true) do |row|
      begin
        # Extract data from each row in the CSV file
        movie = Movie.create!(
          title: row['Title'],
          year: row['Year'],
          imdb_id: row['imdbID'],
          poster: row['Poster'],
          rated: row['Rated'],
          released: row['Released'],
          runtime: row['Runtime'],
          genre: row['Genre'],
          director: row['Director'],
          writer: row['Writer'],
          actors: row['Actors'],
          plot: row['Plot'],
          language: row['Language'],
          country: row['Country'],
          awards: row['Awards'],
          ratings: row['Ratings'],
          metascore: row['Metascore'],
          imdb_rating: row['imdbRating'],
          imdb_votes: row['imdbVotes'],
          movie_type: row['Type'],
          dvd: row['DVD'],
          box_office: row['BoxOffice'],
          production: row['Production'],
          website: row['Website']
        )
        success_count += 1
      rescue => e
        failure_count += 1
        puts "An error occurred: #{e.message}"
      end
    end
    puts "Movies imported successfully: #{success_count}"
    puts "Movies failed to import: #{failure_count}"
    
    Movie.all
  end
end
