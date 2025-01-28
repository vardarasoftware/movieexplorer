require 'sinatra'
require 'csv'
require 'active_record'
require './models/movie'
require './lib/movie_database'
require './importer/movie_importer'

post '/' do
    # params[:file].to_s  # Get the uploaded CSV file
    if params[:file].nil?
        status 400
        return { error: "No file uploaded" }.to_json
    end
    
    file = params[:file][:tempfile]

    begin
        importer = MovieImporter.new
        imported_movies = importer.import(file)
    
        { message: "File imported successfully!", imported_all: imported_movies.all }.to_json
    rescue StandardError => e
        status 500
        { error: "An error occurred during import", details: e.message }.to_json
    end   

end