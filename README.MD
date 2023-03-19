
# HYEL WeatherKit App

## Introduce

An iOS app written in Swift using SwiftUI that fetch data from the [WeatherKit Rest API](https://developer.apple.com/documentation/weatherkitrestapi/get_api_v1_weather_language_latitude_longitude) to show Weather Data. This is an assignment project with minimal required features:

- [x] Implement using Swift and SwiftUI
- [x] Fetch weather from the [Weathe Kit Rest API](https://developer.apple.com/documentation/weatherkitrestapi/get_api_v1_weather_language_latitude_longitude) with hourly and daily datasets

## App Architecture

This application uses **MVVM** as an architecture. **MVVM** in iOS helps developers reduce their file complexity, make it more expressive to the developers and easier to maintain the app.

- **Model**: the data that the app works on, for this application, the models are Weather,... files that can be found in the model directory.
- **View**: the application user interfaces.
- **ViewModel**: handle updating views, UI's logic and data bindings from the models.

This application also that advantages of other patterns like: *dependency injection* and *singleton patterns*. Also implemented a simple caching mechanism using Swift `UserDefaults`. Since weather data are not very persistent, we would avoid using cached weather data and use the latest weather data from the server.

## Feature implementations

### Authentication

To use this demo, please get your WeatherKit authorization token following [WeatherKit documentation](https://developer.apple.com/documentation/weatherkitrestapi/request_authentication_for_weatherkit_rest_api). We save this as an *ENVIRONMENT VARIABLE* with the key `AUTH_TOKEN`. You can set your `AUTH_TOKEN` at your App `Scheme`. Once you finished, everything is ready to go.

### Fetch weather data

We use the [WeatherKit weather endpoint](https://developer.apple.com/documentation/weatherkitrestapi/get_api_v1_weather_language_latitude_longitude) to fetch for weather data. We will pass `language`, `latitude` and `longitude` inside the URL, `https://weatherkit.apple.com/api/v1/weather/{language}/{latitude}/{longitude}`. The remaining parameters to complete our requirements are:

Name  | Value
------------- | -------------
`datasets`| A comma-delimited list of data sets to include in the response.
`dailyStart`| The time to start the hourly forecast. If this parameter is absent, hourly forecasts start on the current hour.

***Note #1***: None of the parameters are required. If you would love to try WeatherKit Rest API, you can visit [WeatherKit documentation](https://developer.apple.com/documentation/weatherkitrestapi/get_api_v1_weather_language_latitude_longitude). The only usage of passing parameters in this project is to fulfill the requirements - fetch daily weather data and fetch hourly data of a given day.

***Note #2***: To have good user experience. Since an API request take time due to networking, battery conditioning and bandwidth, we should update UIs when user tap any weekday, then we shall proceed to send request to the API. If the response is success, we keep the UI, else we inform user with an error. It is good practice for user to see the UI feedback immediately after inputs.

## Installation

1. Clone or download zip file from: [Github Repo](https://github.com/vietmy1711/HYEL-weather-app/) branch `main`
2. Extract zip if downloaded zip file in local machine
3. Make sure local machine has installed latest Xcode 13 and install Simulator 
4. Go to main project dictionary, open `WeatherKitApp.xcodeproj`
5. Update environment variable `AUTH_TOKEN` at `Scheme`
6. Choose target Simulator, and click `Build`
7. After build succeeded, click `Run` to see on Simulator

## Requirements

- Xcode 14, MacOS Ventura
- Swift 5.0
- iOS 15.2
- An iPhone or Simulator

## Author

- Nguyen Viet My - zzvietmyzz@gmail.com