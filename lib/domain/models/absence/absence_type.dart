enum AbsenceType { vacation, sickness, none }

// Use Dart-style enum extension naming (e.g., ThemeModeX, LocaleX) for consistency
extension AbsenceTypeX on AbsenceType {
  static AbsenceType fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'vacation':
        return AbsenceType.vacation;
      case 'sickness':
        return AbsenceType.sickness;
      default:
        return AbsenceType.none;
    }
  }

  String get label {
    switch (this) {
      case AbsenceType.vacation:
        return 'Vacation';
      case AbsenceType.sickness:
        return 'Sickness';
      case AbsenceType.none:
        return 'Unknown';
    }
  }
}
