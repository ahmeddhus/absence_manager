import 'package:absence_manager/data/repositories/absence/absence_repository_local.dart';
import 'package:absence_manager/data/services/api/model/absence/absence_api_model.dart';
import 'package:absence_manager/data/services/local/local_absence_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([LocalAbsenceService])
import 'absence_local_repository_test.mocks.dart';

void main() {
  late MockLocalAbsenceService mockService;
  late AbsenceLocalRepository repository;

  setUp(() {
    mockService = MockLocalAbsenceService();
    repository = AbsenceLocalRepository(mockService);
  });

  group('getAllAbsences', () {
    test('returns correct number of Absences based on pagination', () async {
      // Arrange
      final mockApiModels = List.generate(
        20,
        (index) => AbsenceApiModel(
          id: index,
          userId: 123,
          type: "vacation",
          startDate: "2021-01-01",
          endDate: "2021-01-10",
          memberNote: "Vacation note",
          admitterNote: "Admitter note",
          confirmedAt: "2021-01-05T00:00:00.000+01:00",
          createdAt: null,
          rejectedAt: null,
          crewId: 1,
          status: null,
        ),
      );

      when(mockService.fetchAbsences()).thenAnswer((_) async => mockApiModels);

      // Act
      final result = await repository.getAllAbsences(offset: 10, limit: 5);

      // Assert
      expect(result, hasLength(5));
      expect(result.first.id, 10);
      expect(result.last.id, 14);
    });

    test('returns an empty list when offset exceeds data length', () async {
      // Arrange
      final mockApiModels = List.generate(
        10,
        (index) => AbsenceApiModel(
          id: index,
          userId: 123,
          type: "vacation",
          startDate: "2021-01-01",
          endDate: "2021-01-10",
          memberNote: "Vacation note",
          admitterNote: "Admitter note",
          confirmedAt: "2021-01-05T00:00:00.000+01:00",
          createdAt: null,
          rejectedAt: null,
          crewId: 1,
          status: null,
        ),
      );

      when(mockService.fetchAbsences()).thenAnswer((_) async => mockApiModels);

      // Act
      final result = await repository.getAllAbsences(offset: 20, limit: 5);

      // Assert
      expect(result, isEmpty);
    });

    test('returns the first 10 absences by default', () async {
      // Arrange
      final mockApiModels = List.generate(
        15,
        (index) => AbsenceApiModel(
          id: index,
          userId: 123,
          type: "vacation",
          startDate: "2021-01-01",
          endDate: "2021-01-10",
          memberNote: "Vacation note",
          admitterNote: "Admitter note",
          confirmedAt: "2021-01-05T00:00:00.000+01:00",
          createdAt: null,
          rejectedAt: null,
          crewId: 1,
          status: null,
        ),
      );

      when(mockService.fetchAbsences()).thenAnswer((_) async => mockApiModels);

      // Act
      final result = await repository.getAllAbsences();

      // Assert
      expect(result, hasLength(10));
      expect(result.first.id, 0);
      expect(result.last.id, 9);
    });

    test('handles null fields gracefully with pagination', () async {
      // Arrange
      final mockApiModels = [
        AbsenceApiModel(
          id: 1,
          userId: 123,
          type: "vacation",
          startDate: null,
          endDate: null,
          memberNote: null,
          admitterNote: null,
          confirmedAt: null,
          rejectedAt: null,
          crewId: 1,
        ),
      ];

      when(mockService.fetchAbsences()).thenAnswer((_) async => mockApiModels);

      // Act
      final result = await repository.getAllAbsences(offset: 0, limit: 1);

      // Assert
      expect(result.length, 1);
      final absence = result.first;
      expect(absence.startDate, DateTime(1970));
      expect(absence.endDate, DateTime(1970));
      expect(absence.memberNote, isNull);
      expect(absence.admitterNote, isNull);
    });
  });
}
