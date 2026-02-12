require 'httparty'
require 'dotenv/load'
require 'json'

class MovieAPI
  include HTTParty
  base_uri 'https://www.omdbapi.com'

  def initialize
    @api_key = ENV['OMDB_API_KEY']
    abort("OMDB_API_KEY missing") unless @api_key
  end

  def search_by_title(title)
    response = self.class.get("/", query: {
      apikey: @api_key,
      t: title
    })

    puts response.body

    parse_response(response)
  end
  def search_by_imdb_id(imdb_id)
    response = self.class.get("/",query: {
      apikey: @api_key,
      i: imdb_id
    })
    puts response.body
    
    parse_response(response)
  end  

  private

  def parse_response(response)
    data = JSON.parse(response.body)

    return nil if data["Response"] == "False"
    data
  end
end