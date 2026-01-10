# Animal World

A Flutter educational game app that helps users learn about animals through interactive quizzes and visual exploration.

## 🎮 Main Functionality

**Animal World** is an engaging educational app that combines learning with gameplay. The app includes:

- **Home Screen**: Browse a collection of animals with beautiful card-based UI. Each animal card displays an image and name, allowing users to explore and learn about different animals. Tap on any animal card to view detailed information.
- **Game Screen**: Interactive quiz mode where users are shown an animal image and must select the correct name from four multiple-choice options. Features include:
  - Randomized question generation
  - Score tracking system
  - Game state persistence (resume from where you left off)
  - Visual feedback for correct/incorrect answers
  - Progress tracking with best score storage
- **Profile Screen**: View game statistics, best scores, and games played count

## 🏗️ Architecture

The project follows **Clean Architecture** principles with clear separation of concerns:

- **Presentation Layer**: UI components, screens, widgets, and state management using BLoC pattern
- **Domain Layer**: Business logic, entities (e.g., `Animal`), repositories interfaces, and use cases (e.g., `GetAnimals`, `GetRandomAnimals`)
- **Data Layer**: Local data sources, repository implementations, and models (e.g., `AnimalModel`)

### Key Architectural Features

- **State Management**: BLoC pattern with Events and States for game logic
- **Dependency Injection**: GetIt service locator for managing dependencies
- **Navigation**: GoRouter for declarative routing with bottom navigation
- **Reusable Components**: Shared widgets library including glass cards, gradient buttons, and custom dialogs
- **Service Layer**: Modular services for storage management and logging
- **Theme System**: Centralized theming with custom colors, fonts, spacing, and glass morphism effects
- **Data Persistence**: Local storage using SharedPreferences for game state and statistics

## 🛠️ Tech Stack

- **Flutter** with Dart
- **flutter_bloc** for state management
- **go_router** for navigation
- **get_it** for dependency injection
- **shared_preferences** for local data storage
- **equatable** for value equality
- **flutter_svg** for SVG graphics
- **liquid_glass_renderer** for glass morphism UI effects
- **talker_flutter** & **talker_bloc_logger** for logging and debugging

## 📱 Features

- Interactive animal quiz with multiple-choice questions
- Beautiful animal image gallery
- Score tracking and best score storage
- Game state persistence (resume functionality)
- Glass morphism UI design
- Smooth animations and transitions
- Local data storage for offline use

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: 3.24.x or higher
- **Dart SDK**: 3.10.4 or higher (as specified in `pubspec.yaml`)

### Installation

1. Extract the project archive to your desired location

2. Navigate to the project directory:
   ```bash
   cd animal_world
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

### Building for Release

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## 📝 Notes

- The app uses local storage (SharedPreferences) for game state and statistics
- All animal images are stored in the `assets/png/` directory
- The project uses Inter font family for consistent typography
- Game state is automatically saved, allowing users to resume their progress
