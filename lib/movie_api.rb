## load httparty and dotenv
require 'httparty'
require 'dotenv'
require 'uri'

Dotenv.load
class MovieAPI
  include HTTParty
  BASE_URL = 'http://www.omdbapi.com'

  def initialize
    @api_key = ENV['OMDB_API_KEY']
    puts "API Key: #{@api_key}"
  end

  # Search by movie title
  def search_by_title(title, options = {})
    ## write logic here to call omdb api
    url = build_url({ s: title }.merge(options))
    response = HTTParty.get(url)
    parse_response(response)
  end

  # Search by IMDB ID
  def search_by_imdb_id(imdb_id, options = {})
    ## write logic here to call omdb api
    url = build_url({ i: imdb_id }.merge(options))
    response = HTTParty.get(url)
    parse_response(response)
  end

  private

  def build_url(params)
    uri = URI.parse(BASE_URL)
    uri.query = URI.encode_www_form({ apikey: @api_key }.merge(params))
    uri.to_s
  end

  def parse_response(response)
    # parse raw api responsde data
    if response.success?
      response.parsed_response
    else
      { error: 'Failed to fetch data', code: response.code, message: response.message }
    end
  end
end
