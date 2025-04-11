# absence_manager

A Flutter application to manage and display employee absences. It includes features like listing absences with pagination, filtering by type and date, and displaying absence details such as member name, absence type, period, and status. The app supports loading and error states, as well as an empty state when no results are found. Optionally, the app can generate an iCal file for integration with Outlook.

---

## ✅ Task Checklist

###  Initial Setup
- [x] Set `main` branch protection rules
- [x] Add `ARCHITECTURE.md` with clean architecture overview
- [x] Add project `README.md` with task description and checklist
- [x] Define branch naming conventions in `README.md`

### Core Requirements
- [x] Display a list of absences including employee names
- [x] Show the first 10 absences with pagination
- [ ] Display the total number of absences
- [x] Add unit tests for data, domain, UI, and utility layers

#### For each absence, display:
- [x] Member name
- [x] Type of absence
- [x] Period (start and end date)
- [x] Member note (when available)
- [x] Status (`Requested`, `Confirmed`, or `Rejected`)
- [x] Admitter note (when available)

### Filters & UI States
- [ ] Filter absences by type
- [ ] Filter absences by date
- [x] Show a loading state while data is being fetched
- [x] Show an error state if the list fails to load
- [x] Show an empty state if no results are found

### Bonus Features
- [ ] Generate an iCal file to import into Outlook
- [ ] Create a small, separate API for serving local assets (simulating a backend)

---

## 🧱 Architecture Overview

This project follows clean architecture principles with a layered approach, separating data, domain, and UI concerns. The structure is designed to be modular, scalable, and testable.

The architecture is inspired by the official Flutter team's guidance on scalable app design:  
📘 [Flutter Architecture Guide](https://docs.flutter.dev/app-architecture/guide)

For full implementation details and folder responsibilities, see [ARCHITECTURE.md](ARCHITECTURE.md).

---

## 🔀 Branch Naming Convention

This project follows a clear and consistent branch naming strategy based on the type of work being done:

| Prefix       | Purpose                              | Example                            |
|--------------|--------------------------------------|------------------------------------|
| `feature/`   | New feature or functionality         | `feature/pagination`               |
| `fix/`       | Bug fix                              | `fix/loading-state`                |
| `chore/`     | Setup, tooling, config, non-feature  | `chore/folder-structure`           |
| `docs/`      | Documentation only                   | `docs/architecture-and-readme`     |
| `refactor/`  | Code cleanup with no behavior change | `refactor/usecase-layer`           |
| `test/`      | Adding or updating tests             | `test/bloc-tests`                  |

> Branch names should be lowercase, use hyphens to separate words, and be as descriptive as possible.



