## load httparty and dotenv

class MovieAPI
  base_uri ''

  def initialize
    @api_key = ENV['OMDB_API_KEY']
  end

  # Search by movie title
  def search_by_title(title, options = {})
    ## write logic here to call omdb api
  end

  # Search by IMDB ID
  def search_by_imdb_id(imdb_id, options = {})
    ## write logic here to call omdb api
  end

  

  private

  def parse_response(response)
    # parse raw api responsde data
  end
end 