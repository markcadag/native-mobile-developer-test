# native-mobile-developer-test
Mobile App Development Practical Test

Instructions:

- Fork this repository.
- The candidate is expected to complete the following tasks within 1 week using their preferred development environment and programming languages (e.g., Android - Kotlin/Java, iOS - Swift/Objective-C).
- When finished, make a PR pointing to this repository to the master branch.

Task 1: User Registration and Login

- Create a mobile app with two screens: one for user registration and another for user login. The app should include the following features:
  - User registration with fields for username, email, and password.
  - Proper validation for email format and strong password criteria.
  - Secure storage of user data (e.g., using encrypted keychain in iOS and SharedPreferences in Android).
  - User login with validation against the stored user data.

Task 2: Data Retrieval and Display

- Extend the app to fetch data from a RESTful API (you can use a mock API for testing: https://dummyapi.io/docs with our app-id: 65080fec01538513690ca63e). Display the retrieved data on a new screen. Include these features:
  - Make API requests to retrieve a list of items (e.g., articles, products, or any relevant data).
  - Display the list of items in a scrollable view with appropriate UI components (e.g., RecyclerView in Android and UITableView in iOS).
  - Implement error handling for network failures or API errors.

Task 3: Device Features

- Integrate device-specific features into the app. Implement at least one of the following features on both Android and iOS:

  - Camera integration: Allow users to take a photo and save it within the app.
  - Location services: Retrieve the user's current location and display it on a map.
  - Push notifications: Implement push notifications for important app events.

Task 4: Cross-Platform Compatibility

- Ensure the app is compatible with various screen sizes and orientations. Implement responsiveness for both Android and iOS by handling device rotation and supporting multiple screen sizes.

Task 5: Code Quality and Documentation

- Candidate's code must be good for readability, maintainability, and best practices. Consider the following:

  - Code structure and organization.
  - Proper use of version control (e.g., Git).
  - Documentation (e.g., code comments and README files).
  - Error handling and edge case considerations.

Bonus Task: Unit Testing

- Write unit tests for a specific component or function within the app.
