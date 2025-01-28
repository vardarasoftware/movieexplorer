require_relative 'movie_api'
require_relative 'movie_database'

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
    movie = @api.search_by_title(title)
    if valid_result?(movie)
      if movie['Search'] && movie['Search'].any?
        movie['Search'].each do |m|
          @database.save(m)
        end
      end
      movie['Search']
    else
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
    movie = @api.search_by_imdb_id(imdb_id)
    if valid_result?(movie)
      @database.save(movie)
      movie
    else
      nil
    end
  end

  private

  def valid_result?(result)
    result.is_a?(Hash) && result['Response'] == 'True'
  end
end
