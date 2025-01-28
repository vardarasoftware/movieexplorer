require 'csv'
require_relative '../lib/movie_database'
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
  # CSV_FILE_PATH = '/home/heesha/Projects/movieexplorer/data/movies_dump.csv'

  def initialize
    MovieDatabase.establish_connection
  end

  # Imports movies from the CSV file into the database
  #
  # @return [void]
  def import(file) # rubocop:disable Metrics/MethodLength
    Movie.destroy_all
    puts 'Starting import process...'
    # TODO: Implement CSV import logic
    begin
      CSV.foreach(file, headers: true) do |row|
        Movie.create!(
          title: row['Title'],
          imdb_id: row['imdbID'],
          year: row['Year'],
          genre: row['Genre'],
          director: row['Director'],
          writer: row['Writer'],
          language: row['Language'],
          poster: row['Poster'],
          runtime: row['Runtime']
        )
        puts "Successfully imported: #{row['title']}"
      end

      true
    rescue StandardError => e
      puts "Failed to import row: #{row}. Error: #{e.message}"
      false
    end
  end
end
