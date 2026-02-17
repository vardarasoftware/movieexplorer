require 'json'
require 'byebug'

class SaveMovies
  def save_movie(movie ,filename = "data.json")
    movie_data = {
      title:   movie['Title'],
      year:    movie['Year'],
      imdb_id: movie['imdbID'],
      poster:  movie['Poster']
    }
    movie_store = []

    movie_store = JSON.parse(File.read(filename))

    movie_store << movie_data
    json = JSON.pretty_generate(movie_store)
    File.write(filename,json)



  end
    
end  
