# TMDB iOS App

A native iOS application that allows users to browse and discover movies using The Movie Database (TMDB) API. The app follows clean architecture principles with a clear separation of concerns.

## Project Structure

### 📱 Data Layer
- **Models**: Contains response models for API data
  - `CastResponse`
  - `CreditsResponse`
  - `GenresResponse`
  - `MovieDetailsResponse`
  - `MovieResponse`
- **Networking**: Handles API communication
  - `ApiService`: Manages all API calls to TMDB
- **Repository**: Data access layer
  - `MovieRepository`: Handles movie data operations

### 🎯 Domain Layer
- **Models**: Core business models
  - `CastModel`
  - `GenresModel`
  - `MovieDetailsModel`
  - `MovieModel`

### 🎨 Presentation Layer
- **Design System**
  - `Typo`: Typography definitions
- **Models**: View-specific models
  - `FavoriteMovie`: Model for favorite movies
- **Views**: UI Components
  - **Favourite**: Favorite movies screen
    - `FavouriteMoviesView`
  - **Home**: Main screen
    - `HomeView`
    - `HomeViewModel`
  - **MovieDetails**: Movie details screen
    - `MovieDetailsView`
    - `MovieDetailsViewModel`

### 🎨 Resources
- **Preview Content**
  - Fonts: Metropolis-Regular and Metropolis-SemiBold
  - Preview Assets
- **Assets**: App images and resources

## Features
- Browse popular movies
- View movie details
- See movie cast and crew
- Browse movie genres
- Save favorite movies
- Home screen with curated content
- Detailed movie information view

## Technical Stack
- Swift
- SwiftUI
- MVVM Architecture
- TMDB API integration
- Custom Design System
- Custom Typography (Metropolis font family)

## Requirements
- iOS 18.1+
- Xcode 16.1+

## Installation
1. Clone the repository
```bash
git clone https://github.com/your-username/tmdb-ios.git
```
2. Open `tmdb-ios.xcodeproj` in Xcode
3. Add your TMDB API key in the appropriate configuration file
4. Build and run the project

## Architecture
The project follows a clean architecture approach with three main layers:
- **Data Layer**: Handles external data sources and API communication
- **Domain Layer**: Contains business logic and models
- **Presentation Layer**: Manages UI and user interactions using MVVM pattern

## Configuration
- **API Key**: Obtain an API key from TMDB and configure it in the project.

## Contributing
- **Fork the Repository**: Create a personal fork of the repository.
- **Create a Branch**: Create a new branch for your feature or bugfix.
- **Submit a Pull Request**: Submit a pull request with a detailed description of your changes.
