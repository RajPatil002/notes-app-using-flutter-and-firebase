# NotesApp - Notes App using Flutter And Firebase
NotesApp is a mobile application built using Flutter and Firebase, allowing users to create, view, update, and delete notes in a simple and efficient manner.

## Features

- User Authentication(OTP): Users can log in securely using phone number to access their notes across devices.
- Create Notes: Users can create new notes with a title and content.
- View Notes: Users can view their existing notes in a list format.
- Update Notes: Users can edit and update the title and content of their existing notes.
- Delete Notes: Users can delete unwanted notes when they no longer need them.

<!-- ## Screenshots

*(You can add some screenshots of the app in action here)* -->

## Prerequisites

Before running the app, make sure you have the following installed:

- Flutter SDK: [Flutter installation guide](https://flutter.dev/docs/get-started/install)
- Firebase Account: Create a Firebase project and obtain your `google-services.json` and `GoogleService-Info.plist` files to connect the app to Firebase.

## Getting Started

1. **Clone the repository**:

   ```shell
   git clone https://github.com/RajPatil25/notes-app-using-flutter-and-firebase.git
   cd NotesApp
   ```

2. **Install dependencies**:
   
   ```shell
   flutter pub get
   ```

3. **Add Firebase Configuration:**

    You have to create your own firebase project on [firebase console](https://console.firebase.google.com/).
    
    Add firebase tools:
    ```shell
    npm install -g firebase-tools
    ```
    Login to firebase:
    ```shell
    firebase login
    ```
    Add `firebase_option.dart` , `google-services.json` files to your project directory using following:
    ```shell
    flutter pub add flutter_cli
    flutter pub global activate flutterfire_cli
    flutterfire configure
    ```

4. **Run the app**:
   
   ```shell
   flutter run
   ```