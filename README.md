# Movie Explorer API

A Ruby application that leverages the Open Movie Database (OMDb) API to create a movie exploration service with local data storage capabilities.

## 🎯 Features

- Search movies by title
- Retrieve movie details using IMDB ID
- Store movie data locally in SQLite database
- RESTful API architecture
- Data persistence using ActiveRecord

## 🛠️ Technical Stack

### Core Technologies
- Ruby 3.0+
- SQLite3 (Database)
- ActiveRecord (ORM)

### Required Gems
```ruby
gem 'httparty'    # For API requests
gem 'dotenv'      # Environment variable management
gem 'rubocop'     # Code style enforcement
gem 'activerecord'# Database ORM
gem 'sqlite3'     # Database
```

## 🚀 Getting Started

### Prerequisites
1. Ruby installed on your system
2. SQLite3 installed
3. Postman for API testing
4. OMDb API key ([Get it here](http://www.omdbapi.com/apikey.aspx))

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd movie-explorer
```

2. Install dependencies:
```bash
bundle install
```

3. Configure environment variables:
   - Create a `.env` file in the root directory
   - Add your OMDb API key:
```bash
OMDB_API_KEY=your_api_key_here
```

4. Set up the database:
```bash
rake db:create
rake db:migrate
```

## 📖 API Documentation

### Base URL
```
http://www.omdbapi.com/?apikey=[yourkey]&
```

### Endpoints

#### 1. Search Movie by Title
```http
GET /?t={movie_title}
```

Example:
```bash
curl "http://www.omdbapi.com/?apikey=YOUR_KEY&t=Matrix"
```

#### 2. Search Movie by IMDB ID
```http
GET /?i={imdb_id}
```

Example:
```bash
curl "http://www.omdbapi.com/?apikey=YOUR_KEY&i=tt0133093"
```

## 💾 Database Schema

```sql
CREATE TABLE movies (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255),
  year VARCHAR(10),
  rated VARCHAR(10),
  released DATE,
  runtime VARCHAR(20),
  genre VARCHAR(255),
  director VARCHAR(255),
  plot TEXT,
  imdb_id VARCHAR(20) UNIQUE,
  imdb_rating DECIMAL(3,1),
  created_at DATETIME,
  updated_at DATETIME
);
```

## 🧪 Testing

### Postman Testing
1. Import the provided Postman collection
2. Update the API key in environment variables
3. Run the collection to test all endpoints

### Ruby Tests
```bash
rake test
```

## 📝 Code Style

This project follows Ruby style guidelines enforced by RuboCop. To check your code:

```bash
rubocop
```

To auto-correct issues:
```bash
rubocop -a
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## 🙏 Acknowledgments

- [OMDb API](http://www.omdbapi.com/) for providing the movie database
- Ruby and its amazing community
- All contributors to this project

## 📞 Support

For support, please open an issue in the GitHub repository or contact the maintainers.
