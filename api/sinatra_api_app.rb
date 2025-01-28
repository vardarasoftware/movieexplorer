require 'sinatra'
require 'active_record'
require 'csv'
require 'byebug'
require_relative '../lib/movie_database'
require_relative '../models/movie'
require_relative '../importer/movie_importer'

MovieDatabase.establish_connection

post '/import_movies' do
  unless params[:file] && params[:file][:tempfile]
    status 400
    return 'File is required'
  end

  uploaded_file = params[:file][:tempfile]

  begin
    importer = MovieImporter.new
    success = importer.import(uploaded_file)

    if success
      status 200
      return 'Movies imported successfully!'
    else
      status 500
      return 'Failed to import movies'
    end
  rescue StandardError => e
    status 500
    return "Failed to import movies: #{e.message}"
  end
end
