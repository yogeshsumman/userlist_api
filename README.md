# User List App

## Overview

The User List App is a Flutter-based mobile application that allows users to log in, view a list of users fetched from the ReqRes API, and update user details (name and job) using a slide gesture. The app features persistent login, a clean UI with a custom theme, and smooth navigation. It’s designed to demonstrate core Flutter concepts like state management, API integration, and gesture-based interactions.

## Features

- **Persistent Login:** Users remain logged in across app restarts using `shared_preferences` until they explicitly sign out.
- **User List Display:** Fetches and displays a list of users from the ReqRes API.
- **Slide-to-Update:** Swipe right-to-left on a user card to update their name and job.
- **Custom Theme:** Consistent styling across the app with a custom `ThemeData` defined in `theme.dart`.
- **Sign Out:** A "Sign Out" button in the app bar to log out and return to the login screen.

## System Architecture

The app follows a layered architecture with clear separation of concerns, ensuring maintainability and scalability. Below is a diagram illustrating the system’s components and their interactions:

```
+---------------------------------------------+
|                 User (UI)                   |
|  (LoginScreen, HomeBody, UpdateUserScreen)  |
+---------------------------------------------+
                |         ^
                v         |
+---------------------------------------------+
|              Presentation Layer             |
|  (Widgets: UserCard, Screens)               |
|  - Displays UI                              |
|  - Handles user interactions (e.g., swipe)  |
+---------------------------------------------+
                |         ^
                v         |
+---------------------------------------------+
|               Controller Layer              |
|  (AuthController, UserController)           |
|  - Manages business logic                   |
|  - Interacts with services                  |
+---------------------------------------------+
                |         ^
                v         |
+---------------------------------------------+
|                Service Layer                |
|  (ApiService, AuthPrefs)                    |
|  - ApiService: Handles HTTP requests (Dio)  |
|  - AuthPrefs: Manages login state (SharedPreferences) |
+---------------------------------------------+
                |         ^
                v         |
+---------------------------------------------+
|                 Data Layer                  |
|  (Models: User, AuthResponse, UpdateUserResponse) |
|  - Defines data structures                  |
|  - Parses API responses                     |
+---------------------------------------------+
                |         ^
                v         |
+---------------------------------------------+
|               ReqRes API                    |
|  - Provides user data and authentication    |
+---------------------------------------------+
```

### Diagram Explanation

- **User (UI):** The user interacts with the app through screens like `LoginScreen` (for authentication), `HomeBody` (for the user list), and `UpdateUserScreen` (for updating user details).
- **Presentation Layer:** Contains widgets like `UserCard` (for displaying user info with a slide gesture) and screens. It handles UI rendering and user interactions, forwarding events (e.g., swipe to update) to the controller layer.
- **Controller Layer:** `AuthController` manages login/logout, and `UserController` handles user data operations (fetching and updating). This layer bridges the UI and services.
- **Service Layer:** `ApiService` uses the Dio package to make HTTP requests to the ReqRes API. `AuthPrefs` uses `shared_preferences` to persist the login state.
- **Data Layer:** Models like `User`, `AuthResponse`, and `UpdateUserResponse` define the app’s data structures and parse API responses.
- **ReqRes API:** An external REST API providing user data and mock authentication endpoints.

### Flow Example

1. The user logs in via `LoginScreen`.
2. `AuthController` calls `ApiService` to authenticate with the ReqRes API.
3. On success, `AuthPrefs` saves the login state.
4. The app navigates to `HomeBody`, where `UserController` fetches users via `ApiService`.
5. `UserCard` displays users and allows swipe-to-update, triggering `UserController` to update user data via `ApiService`.

## Setup Instructions

### Prerequisites

- Flutter SDK (version 3.0.0 or higher)
- Dart (version 2.12.0 or higher)
- An IDE (e.g., VS Code, Android Studio)
- A device/emulator for testing

### Installation

1. **Clone the Repository:**
   ```sh
   git clone <repository-url>
   cd user-list-app
   ```

2. **Install Dependencies:**
   ```sh
   flutter pub get
   ```
   This installs required packages like `dio`, `flutter_slidable`, and `shared_preferences` (see `pubspec.yaml`).

3. **Run the App:**
   ```sh
   flutter run
   ```
   Ensure a device or emulator is connected.

## Usage

### Login

- Launch the app and enter credentials on the `LoginScreen`.
- Use `eve.holt@reqres.in` with password `cityslicka` (ReqRes API test credentials).
- On successful login, you’ll be navigated to the user list (`HomeBody`).

### View Users

- The user list displays users fetched from the ReqRes API.
- Each user is shown in a `UserCard` with their name, email, and job (if available).

### Update a User

- Swipe right-to-left on a user card to reveal the "Update" action.
- Tap "Update" to navigate to `UpdateUserScreen`.
- Edit the user’s name and job, then tap "Update" to save changes.
- Changes are reflected locally in the user list (ReqRes API doesn’t persist updates).

### Sign Out

- Tap the "Sign Out" icon in the AppBar of `HomeBody` to log out.
- You’ll be navigated back to the `LoginScreen`.

## Dependencies

- **flutter:** The core Flutter SDK.
- **dio:** ^5.3.3 — For making HTTP requests to the ReqRes API.
- **flutter_slidable:** ^3.1.1 — For implementing the slide-to-update gesture.
- **shared_preferences:** ^2.3.0 — For persisting the login state.

See `pubspec.yaml` for the full list.

## Future Improvements

- **Real Backend:** Replace the ReqRes API with a real backend to persist user updates.
- **Delete Feature:** Add a left-to-right slide gesture to delete users (currently removed).
- **Local Storage:** Use `sqflite` to cache user data locally for offline support.
- **Dark Mode:** Add support for dark/light themes using `themeMode`.
- **Input Validation:** Add form validation in `LoginScreen` and `UpdateUserScreen` for better UX.
- **Dependency Injection:** Use a library like `get_it` for better dependency management.

## License

This project is licensed under the MIT License - see the LICENSE file for details.