import 'package:absence_manager/data/repositories/absence/absence_repository_local.dart';
import 'package:absence_manager/data/services/api/model/absence/absence_api_model.dart';
import 'package:absence_manager/data/services/local/local_absence_service.dart';
import 'package:absence_manager/domain/models/absence/absence.dart';
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
    test('returns list of Absence domain models', () async {
      // Arrange
      final mockApiModels = [
        AbsenceApiModel(
          id: 1,
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
      ];

      when(mockService.fetchAbsences()).thenAnswer((_) async => mockApiModels);

      // Act
      final result = await repository.getAllAbsences();

      // Assert
      expect(result, isA<List<Absence>>());
      expect(result.length, 1);
      final absence = result.first;
      expect(absence.id, 1);
      expect(absence.userId, 123);
      expect(absence.type, "vacation");
      expect(absence.startDate, DateTime(2021, 1, 1));
      expect(absence.endDate, DateTime(2021, 1, 10));
      expect(absence.memberNote, "Vacation note");
      expect(absence.admitterNote, "Admitter note");
      expect(absence.status, AbsenceStatus.confirmed);
    });

    test('correctly assigns AbsenceStatus based on timestamps', () async {
      // Arrange
      final mockApiModels = [
        AbsenceApiModel(
          id: 1,
          userId: 123,
          type: "sickness",
          startDate: "2021-01-01",
          endDate: "2021-01-10",
          confirmedAt: null,
          rejectedAt: null,
          crewId: 1,
        ),
        AbsenceApiModel(
          id: 2,
          userId: 123,
          type: "sickness",
          startDate: "2021-01-01",
          endDate: "2021-01-10",
          confirmedAt: "2021-01-05T00:00:00.000+01:00",
          rejectedAt: null,
          crewId: 1,
        ),
        AbsenceApiModel(
          id: 3,
          userId: 123,
          type: "sickness",
          startDate: "2021-01-01",
          endDate: "2021-01-10",
          confirmedAt: null,
          rejectedAt: "2021-01-06T00:00:00.000+01:00",
          crewId: 1,
        ),
      ];

      when(mockService.fetchAbsences()).thenAnswer((_) async => mockApiModels);

      // Act
      final result = await repository.getAllAbsences();

      // Assert
      expect(result.length, 3);
      expect(result[0].status, AbsenceStatus.requested);
      expect(result[1].status, AbsenceStatus.confirmed);
      expect(result[2].status, AbsenceStatus.rejected);
    });

    test('returns an empty list when no data available', () async {
      // Arrange
      when(mockService.fetchAbsences()).thenAnswer((_) async => []);

      // Act
      final result = await repository.getAllAbsences();

      // Assert
      expect(result, isA<List<Absence>>());
      expect(result, isEmpty);
    });

    test('handles null fields gracefully', () async {
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
      final result = await repository.getAllAbsences();

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
