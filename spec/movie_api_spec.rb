require 'spec_helper'
require_relative '../lib/movie_api'

RSpec.describe MovieAPI do
  let(:api) { MovieAPI.new }

  before do
    # Ensure API key is set for testing
    ENV['OMDB_API_KEY'] = 'your_test_api_key'
  end

  describe '#initialize' do
    it 'raises an error if API key is missing' do
      ENV['OMDB_API_KEY'] = nil
      expect { MovieAPI.new }.to raise_error(ArgumentError, /API key is missing/)
    end
  end

  describe '#search_by_title' do
    context 'when movie exists' do
      it 'returns movie details' do
        VCR.use_cassette('movie_by_title') do
          result = api.search_by_title('Inception')
          expect(result).to be_a(Hash)
          expect(result['Title']).to eq('Inception')
        end
      end
    end

    context 'when movie does not exist' do
      it 'returns nil' do
        VCR.use_cassette('nonexistent_movie') do
          result = api.search_by_title('NonexistentMovieTitle123')
          expect(result).to be_nil
        end
      end
    end
  end

  describe '#search_by_imdb_id' do
    context 'when movie exists' do
      it 'returns movie details' do
        VCR.use_cassette('movie_by_imdb_id') do
          result = api.search_by_imdb_id('tt1375666')
          expect(result).to be_a(Hash)
          expect(result['imdbID']).to eq('tt1375666')
        end
      end
    end

    context 'when IMDB ID does not exist' do
      it 'returns nil' do
        VCR.use_cassette('nonexistent_imdb_id') do
          result = api.search_by_imdb_id('tt0000000')
          expect(result).to be_nil
        end
      end
    end
  end

  describe '#search_movies' do
    context 'when search returns results' do
      it 'returns multiple movie results' do
        VCR.use_cassette('multiple_movies') do
          result = api.search_movies('Matrix')
          expect(result).to be_a(Hash)
          expect(result[:search_results]).to be_an(Array)
          expect(result[:total_results]).to be > 0
        end
      end
    end

    context 'when no movies match search' do
      it 'returns nil' do
        VCR.use_cassette('no_search_results') do
          result = api.search_movies('NonexistentMovieTitle123')
          expect(result).to be_nil
        end
      end
    end
  end
end 