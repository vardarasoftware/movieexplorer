require 'movie_explorer'

class SaveMovies
    def save(movie)
    {
      title:   movie['Title'],
      year:    movie['Year'],
      imdb_id: movie['imdbID'],
      poster:  movie['Poster']
    }  
    end
    
end        
