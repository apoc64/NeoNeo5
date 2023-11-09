# NeoNeo5
Near Earth Object Tracker consuming a NASA API

This is a simplified version of https://github.com/apoc64/NeoNeo4 for demo purposes

## Setup

With the repo cloned, open NeoNeo4.xcodeproj in Xcode.

### Running the app

To run the app on the selected simulator or authorized device, press Command + R, or press the play button in the toolbar.

To run the tests, press Command + U, or use the dropdown from the play button.

## About the App

The app is built in SwiftUI. There is a tab bar for the NEO list and a settings view. The NEO list displays results from the API call. Tapping a list item will go to a detail view. The settings view does not affect anything, but does store its settings in UserDefaults.

The app uses a NetworkingManager which uses URLSession when the app is running, or a MockURLSession that returns static JSON in test. They are configured using Container, which can be used for dependency injection. The ServiceResponseModel protocol allows Codable response structs to fetch themselves through NetworkingManager.

