require_relative 'movie_api'
require_relative 'movie_database'
require_relative 'show_table'

class MovieExplorer
  def initialize
    @api = MovieAPI.new
    @database = MovieDatabase.new
    MovieDatabase.establish_connection
  end

  def search_and_save_by_title(title)
    # Searches for a movie by title using the MovieAPI
    # Saves the movie to the database if found
    # Returns the movie data or nil if no movie is found
    movie_data = @api.search_by_title(title)
    # puts movie_data
    if movie_data && movie_data['Response'] == 'True'
      movie_data['Search'].each do |movie|
        @database.save_movie(movie)
      end
      TableDisplay.display_searched_movies(movie_data['Search']) 
      # movie_data['Search']
    else
      puts "No movie found with title: #{title}"
      nil
    end
  end

  def search_and_save_by_imdb_id(imdb_id)
    # Searches for a movie by its IMDB ID using the MovieAPI
    # 
    # @param imdb_id [String] The unique IMDB identifier for the movie
    # @return [Hash, nil] The movie data if found, or nil if no movie is found
    # 
    # This method:
    # 1. Queries the MovieAPI for a movie using the provided IMDB ID
    # 2. If a movie is found, saves it to the database
    # 3. Returns the movie data or nil
    movie_data = @api.search_by_imdb_id(imdb_id)
    # puts movie_data
    if movie_data && movie_data['Response'] == 'True'
      @database.save_movie(movie_data)
      movie_data_arr = [movie_data]
      TableDisplay.display_searched_movies(movie_data_arr) 
    else
      puts "No movie found with imdb_id: #{imdb_id}"
      nil
    end
  end

end 