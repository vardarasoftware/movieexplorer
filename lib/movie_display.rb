require 'table_print'
require_relative 'movie_database'

class MovieDisplay
  def initialize
    MovieDatabase.establish_connection
  end

  def display_all_movies
    movies = Movie.all
    tp movies, :id, :title, :year, :imdb_id, :poster, :genre, :director, :language, :writer, :runtime, :created_at
  end

  def display_movie_by_title(title)
    movie = Movie.find_by(title: title)
    if movie
      tp [movie], :id, :title, :year, :imdb_id, :poster, :genre, :director, :language, :writer, :runtime, :created_at
    else
      puts "No movie found with title: #{title}"
    end
  end

  def display_movie_by_imdb_id(imdb_id)
    movie = Movie.find_by(imdb_id: imdb_id)
    if movie
      tp [movie], :id, :title, :year, :imdb_id, :poster, :genre, :director, :language, :writer, :runtime, :created_at
    else
      puts "No movie found with IMDB ID: #{imdb_id}"
    end
  end

  def display_recent_movies(limit = 5)
    movies = Movie.order(created_at: :desc).limit(limit)
    tp movies, :id, :title, :year, :imdb_id, :poster, :genre, :director, :language, :writer, :runtime, :created_at
  end
end
