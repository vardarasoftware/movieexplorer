require 'table_print'
require 'active_record'
require_relative '../models/movie'

class TableDisplay
  # Fetches all movies and displays them in a table format
  def self.display_searched_movies(movies)
    if movies.any?
      tp movies.map { |movie| { 
        title: movie['Title'], 
        year: movie['Year'], 
        imdb_id: movie['imdbID'], 
        poster: movie['Poster'], 
        rated: movie['Rated'],
        released: movie['Released'],
        runtime: movie['Runtime'],
        genre: movie['Genre'],
        director: movie['Director'],
        writer: movie['Writer'],
        actors: movie['Actors'],
        plot: movie['Plot'],
        language: movie['Language'],
        country: movie['Country'],
        awards: movie['Awards'],
        ratings: movie['Ratings'],
        metascore: movie['Metascore'],
        imdb_rating: movie['imdbRating'],
        imdb_votes: movie['imdbVotes'],
        movie_type: movie['Type'],
        dvd: movie['DVD'],
        box_office: movie['BoxOffice'],
        production: movie['Production'],
        website: movie['Website']
      } }
    else
      puts "No movies found in the search results."
    end
  end
end
