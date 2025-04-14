# 🧱 Project Architecture

This project is built using a clean, layered architecture inspired by the Flutter team's official [Flutter Architecture Guide](https://docs.flutter.dev/app-architecture/guide).

It separates the app into three main layers:

- **Data Layer** – Responsible for retrieving and persisting data (e.g., local assets or remote APIs).
- **Domain Layer** – Contains business logic, entities, and use cases. Pure Dart — no Flutter dependencies.
- **UI Layer** – Manages presentation, state (via BLoC), and user interaction.

---

## 📁 Folder Structure

```
lib/
├── config/                   # Global configuration (themes, setup, DI, etc.)
├── core/                     # Cross-cutting concerns and foundational logic
│   ├── network/              # Custom HTTP client, network checker
│   └── result/               # Functional types like Result, ResultExtensions
├── data/                     # Data retrieval/storage
│   ├── repositories/         # Repository interfaces and implementations
│   │   ├── <feature_a>/      # e.g., entity_a_repository.dart
│   │   └── <feature_b>/      # e.g., entity_b_repository.dart
│   └── services/             # Low-level APIs, local data loaders
│       ├── api/
│       │   └── model/        # API data models (DTOs)
│       └── local/            # JSON loaders, local storage (Hive, SharedPrefs)
├── domain/                   # Business logic and core entities
│   ├── models/               # Pure Dart entities (no Flutter deps)
│   └── usecases/             # Application actions (pagination, filtering)
├── ui/                       # Presentation layer (screens, widgets, state)
│   └── <feature_screen>/     # Feature-specific UI
│       ├── bloc/             # State management with BLoC/Cubit
│       └── widgets/          # Reusable UI components for that feature
├── utils/                    # Global helpers, extensions, validators
└── main.dart                 # Application entry point

```

---

## ✨ Layer Responsibilities

- **Data Layer**
    - Abstracts data sources (local or remote).
    - Exposes repositories that the domain layer depends on.
    - Contains services for file loading, network communication, and storage.

- **Domain Layer**
    - Houses app-specific business logic, core entities, and use cases.
    - Fully decoupled from Flutter and third-party libraries.

- **UI Layer**
    - Displays application state to the user and handles input.
    - Uses BLoC for reactive state management.
    - Communicates only with the domain layer, not directly with data sources.

- **Core Layer**
    - Holds shared utilities, constants, styles, and helpers used across layers.

---

## 🔄 Example Data Flow

1. The UI dispatches an event (e.g., user scrolls to load more).
2. The BLoC handles the event and invokes a **use case** from the domain layer.
3. The use case interacts with the necessary **repository**, which retrieves data from local or remote **services**.
4. The processed result is returned to the BLoC, which updates the UI state.

---

This structure is designed to be **modular**, **testable**, and **scalable** — allowing clean feature isolation, easy unit testing, and flexibility for future growth (e.g., switching APIs, adding caching, offline support).