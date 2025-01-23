## load httparty and dotenv
require 'httparty'
require 'dotenv'

Dotenv.load

class MovieAPI
  BASE_URL = 'https://www.omdbapi.com'

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
    response = HTTParty.get("#{BASE_URL}/?apikey=#{@api_key}&i=#{imdb_id}")
    parse_response(response)
  end

  

  private

  def parse_response(response)
    # parse raw api responsde data
    if response.code == 200
        response.parsed_response
      else
        puts "HTTP Error: #{response.code}"
        nil
      end
  end
end 