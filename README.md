# absence_manager

A Flutter application to manage and display employee absences. It includes features like listing absences with pagination, filtering by type and date, and displaying absence details such as member name, absence type, period, and status. The app supports loading and error states, as well as an empty state when no results are found. Optionally, the app can generate an iCal file for integration with Outlook.

---

## 🧱 Architecture Overview

This project follows clean architecture principles with a layered approach, separating data, domain, and UI concerns. The structure is designed to be modular, scalable, and testable.

The architecture is inspired by the official Flutter team's guidance on scalable app design:  
📘 [Flutter Architecture Guide](https://docs.flutter.dev/app-architecture/guide)

For full implementation details and folder responsibilities, see [ARCHITECTURE.md](ARCHITECTURE.md).

---

## 📡 Backend API

This app is powered by a custom NestJS API I built and deployed using Railway.  
For API details, routes, and setup instructions, see the backend [README.md](https://github.com/ahmeddhus/absence-api-nestjs/blob/master/README.md).

---

## ✅ Task Checklist

### Initial Setup
- [x] Set `main` branch protection rules
- [x] Add `ARCHITECTURE.md` with clean architecture overview
- [x] Add project `README.md` with task description and checklist
- [x] Define branch naming conventions in `README.md`
- [x] Deploy to GitHub Pages

### Core Requirements
- [x] Display a list of absences including employee names
- [x] Show the first 10 absences with pagination
- [x] Display the total number of absences
- [x] Add unit tests for data, domain, UI, and utility layers

#### For each absence, display:
- [x] Member name
- [x] Type of absence
- [x] Period (start and end date)
- [x] Member note (when available)
- [x] Status (`Requested`, `Confirmed`, or `Rejected`)
- [x] Admitter note (when available)

### Filters & UI States
- [x] Filter absences by type
- [x] Filter absences by date
- [x] Show a loading state while data is being fetched
- [x] Show an error state if the list fails to load
- [x] Show an empty state if no results are found

### Bonus Features
- [x] Generate an iCal file to import into Outlook
- [x] Create a small, separate API for serving local assets (simulating a backend)

---

## 🌐 Live Demo

You can view and test the deployed app here:  
🔗 [https://ahmeddhus.github.io/absence_manager/](https://ahmeddhus.github.io/absence_manager/)

### 🔄 Hot Reload Tip
If you’ve visited the page before, your browser may cache an older version.  
To see the latest version (`v1.3.2+1`), perform a **hard refresh**:

- **Windows/Linux**: `Ctrl + Shift + R`
- **Mac**: `Cmd + Shift + R`

---

## 🔀 Branch Naming Convention

This project follows a consistent and descriptive branch naming strategy.

📄 See full details in [BRANCHING.md](BRANCHING.md)

---

## 📦 Packages Used

| Package                 | Purpose                                                                 |
|--------------------------|-------------------------------------------------------------------------|
| `flutter_bloc`           | State management using the BLoC pattern                                 |
| `equatable`              | Simplifies equality checks in BLoC states and events                    |
| `http`                   | Used for networking and connectivity checks                             |
| `hive` / `hive_flutter`  | Lightweight and fast local data storage for offline caching             |
| `package_info_plus`      | Fetches app version and package info for display in the Info dialog     |
| `path_provider`          | Provides file storage paths needed by Hive                              |
| `get_it`                 | Service locator for dependency injection                                |
| `share_plus`             | Enables sharing exported iCal files                                     |
| `universal_html`         | Cross-platform HTML support for iCal export (especially web)            |
| `freezed` / `freezed_annotation` | Code generation for immutable models                          |
| `json_serializable` / `json_annotation` | JSON serialization for API and local models            |

### 🧪 Dev/Test Dependencies

| Package            | Purpose                                                                 |
|--------------------|-------------------------------------------------------------------------|
| `flutter_test`     | Flutter’s official test library                                         |
| `bloc_test`        | Unit testing support for Cubits and BLoCs                               |
| `mockito`          | Mocking dependencies in unit tests                                      |
| `build_runner`     | Code generation for models and adapters                                 |
| `hive_generator`   | Generates type adapters for Hive models                                 |
| `flutter_lints`    | Enforces recommended lint rules                                          |

---
