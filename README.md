# Flutter Project

## Overview
This Flutter project is designed to fetch and display blog posts stored in Firebase Firestore. It includes features such as reading blog content, deep linking, and an efficient state management system.

## Project Setup Instructions

### Prerequisites
- Install [Flutter](https://flutter.dev/docs/get-started/install)
- Install [Dart](https://dart.dev/get-dart)
- Configure a Firebase project and enable Firestore
- Enable Developer Mode on Windows if using Windows OS

### Steps to Run the Project
1. Clone the repository:
   ```sh
   git clone https://github.com/zarity-health-Blog-POSTS.git
   cd zarity-health-Blog-POSTS
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Configure Firebase:
   - Ensure Firestore is enabled and properly set up in Firebase Console
4. Run the app:
   ```sh
   flutter run
   ```

## Assumptions & Additional Features
- The app fetches and displays blog posts from Firestore.
- Each blog post consists of an `imageURL`, `title`, `summary`, `content`, and `deeplink`.
- Clicking "Read More" navigates to a full blog content page.
- Error handling and loading indicators are implemented.
- Uses `flutter_bloc` for state management.

## State Management Solution
The project uses **BLoC (Business Logic Component)** for state management. The `flutter_bloc` package ensures a scalable and efficient architecture, separating UI from business logic.

### BLoC Structure:
- **Bloc:** Handles business logic.
- **Events:** Defines user actions like fetching blogs.
- **States:** Represents different UI states (loading, success, error).
- **Repository:** Handles Firestore interactions.

## Project Structure
```
lib/
│── main.dart               # Entry point of the app
│── models/             # Data models (e.g., BlogPost model)        
│── bloc/           # BLoC state management          
│── widgets/       # Reusable widgets
│── components     #app and screens
│── routes         # deep linking
│── assets/
│   ├── fonts/              # Custom fonts
│   ├── images/             # Static images
│── pubspec.yaml            # Dependencies & assets declaration
│── README.md               # Project documentation
```

## Dependencies Used
- `flutter_bloc`: State management
- `firebase_core`: Firebase integration
- `cloud_firestore`: Firestore database


## Contact
For queries or contributions, feel free to open an issue or contact me at [oli2k3@gmail.com].

