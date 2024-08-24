# Track It
Track It is an iOS application developed as part of an iOS mobile development course. The app allows users to search and explore movies using the [RapidAPI MoviesDatabase API](https://rapidapi.com/dolphinnoirbusiness/api/moviedatabase8).

## Getting Started
To get started with the project, follow these steps:

### Prerequisites
Ensure that you have the following installed on your development environment:

* Xcode
* Swift

### setup
1. Clone the Repository
```bash
git clone [your-repository-url]
cd TrackIt
```

2. Create Config.plist
   
To configure the app, you need to create a Config.plist file in the project directory.

* Open Xcode.
* Right-click on the project folder in the Xcode navigator.
* Select New File > Property List and name it Config.plist.
* Add a new key-value pair:
  
  Key: `API_KEY`
  
  Value: `[Your RapidAPI MoviesDatabase API Key]`

(Replace `[Your RapidAPI MoviesDatabase API Key]` with your actual API key from the [RapidAPI MoviesDatabase API](https://rapidapi.com/dolphinnoirbusiness/api/moviedatabase8).)

3. Add Dependencies Using Swift Package Manager

Open your project in Xcode.
Go to File > Add Packages

Search for and add all of the required packages - AlamofireImage, Firebase.

Follow the prompts to integrate the packages into your project.

Build and Run

4. Open the TrackIt.xcodeproj file in Xcode.
   
Build the project by selecting the appropriate simulator or device.

Run the app to start using Track It.

### Features
* Search Movies: Search for movies by title using the MoviesDatabase API.
* View Movie Details: Get detailed information about movies, including release date, runtime, and overview.
* Save Favorites: Save your favorite movies for easy access.
