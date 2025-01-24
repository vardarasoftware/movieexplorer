require 'table_print'
require 'active_record'
require_relative '../models/movie'

class TableDisplay
  # Fetches all movies and displays them in a table format
  def self.display_searched_movies(movies)
    if movies.any?
      tp movies.map { |movie| { title: movie['Title'], year: movie['Year'], imdb_id: movie['imdbID'], poster: movie['Poster'] } }
    else
      puts "No movies found in the search results."
    end
  end
end
