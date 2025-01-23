## load httparty and dotenv
require 'httparty'
require 'dotenv'

Dotenv.load

class MovieAPI
  include HTTParty
  BASE_URL = 'http://www.omdbapi.com'

  def initialize
    @api_key = ENV['OMDB_API_KEY']
  end

  # Search by movie title
  def search_by_title(title, options = {})
    ## write logic here to call omdb api
    response = HTTParty.get("#{BASE_URL}/?apikey=#{@api_key}&s=#{title}")
    parse_response(response)
  end

  # Search by IMDB ID
  def search_by_imdb_id(imdb_id, options = {})
    ## write logic here to call omdb api
    response = HTTParty.get("#{BASE_URL}/?&apikey=#{@api_key}&i=#{imdb_id}")
    parse_response(response)
  end

  private

  def parse_response(response)
    # parse raw api responsde data
    if response.success?
      response.parsed_response
    else
      { error: 'Failed to fetch data', code: response.code, message: response.message }
    end
  end
end
