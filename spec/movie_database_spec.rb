require 'spec_helper'
require_relative '../lib/movie_database'

RSpec.describe MovieDatabase do
  before(:each) do
    MovieDatabase.establish_connection('test')
    MovieDatabase.migrate
  end

  describe '.establish_connection' do
    it 'establishes a database connection' do
      expect(ActiveRecord::Base.connection).to be_connected
    end
  end

  describe '.migrate' do
    it 'creates movies table' do
      columns = ActiveRecord::Base.connection.columns(:movies)
      column_names = columns.map(&:name)

      expect(column_names).to include('id', 'title', 'year', 'imdb_id', 'poster')
    end
  end

  describe '.save_movie' do
    let(:movie_data) {
      {
        'Title' => 'Inception',
        'Year' => '2010',
        'imdbID' => 'tt1375666',
        'Poster' => 'http://example.com/poster.jpg',
        'Plot' => 'A mind-bending thriller',
        'Genre' => 'Sci-Fi, Action',
        'Director' => 'Christopher Nolan',
        'imdbRating' => '8.8'
      }
    }

    it 'saves a movie to the database' do
      movie = MovieDatabase.save_movie(movie_data)
      expect(movie).to be_a(Movie)
      expect(movie.title).to eq('Inception')
      expect(movie.imdb_id).to eq('tt1375666')
    end

    context 'when saving duplicate movie' do
      it 'prevents duplicate entries' do
        MovieDatabase.save_movie(movie_data)
        expect {
          MovieDatabase.save_movie(movie_data)
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end 