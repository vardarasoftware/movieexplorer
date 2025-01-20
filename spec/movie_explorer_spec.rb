require 'spec_helper'
require_relative '../lib/movie_explorer'

RSpec.describe MovieExplorer do
  let(:explorer) { MovieExplorer.new }

  before(:each) do
    MovieDatabase.establish_connection('test')
    MovieDatabase.migrate
  end

  describe '#search_and_save_by_title' do
    context 'when movie exists' do
      it 'saves and returns movie details' do
        VCR.use_cassette('search_by_title') do
          result = explorer.search_and_save_by_title('Inception')
          expect(result).to be_a(Hash)
          expect(result['Title']).to eq('Inception')
          expect(Movie.find_by(title: 'Inception')).to be_present
        end
      end
    end

    context 'when movie does not exist' do
      it 'returns nil' do
        VCR.use_cassette('nonexistent_title') do
          result = explorer.search_and_save_by_title('NonexistentMovieTitle123')
          expect(result).to be_nil
        end
      end
    end
  end

  describe '#search_and_save_by_imdb_id' do
    context 'when movie exists' do
      it 'saves and returns movie details' do
        VCR.use_cassette('search_by_imdb_id') do
          result = explorer.search_and_save_by_imdb_id('tt1375666')
          expect(result).to be_a(Hash)
          expect(result['imdbID']).to eq('tt1375666')
          expect(Movie.find_by(imdb_id: 'tt1375666')).to be_present
        end
      end
    end

    context 'when IMDB ID does not exist' do
      it 'returns nil' do
        VCR.use_cassette('nonexistent_imdb_id') do
          result = explorer.search_and_save_by_imdb_id('tt0000000')
          expect(result).to be_nil
        end
      end
    end
  end

  describe '#search_movies' do
    context 'when search returns results' do
      it 'saves and returns multiple movies' do
        VCR.use_cassette('search_multiple_movies') do
          result = explorer.search_movies('Matrix')
          expect(result).to be_a(Hash)
          expect(result[:search_results]).to be_an(Array)
          expect(result[:total_results]).to be > 0
          expect(Movie.where(title: result[:search_results].map { |m| m['Title'] }).count).to be > 0
        end
      end
    end
  end
end 