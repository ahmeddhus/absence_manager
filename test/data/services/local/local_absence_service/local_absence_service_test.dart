import 'package:absence_manager/data/services/api/model/absence/absence_api_model.dart';
import 'package:absence_manager/data/services/local/local_absence_service.dart';
import 'package:absence_manager/data/services/local/local_json_loader.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([LocalJsonLoader])
import 'local_absence_service_test.mocks.dart';

void main() {
  late MockLocalJsonLoader mockLoader;
  late LocalAbsenceService service;

  setUp(() {
    mockLoader = MockLocalJsonLoader();
    service = LocalAbsenceService(mockLoader);
  });

  test('fetchAbsences returns list of AbsenceApiModel', () async {
    final mockJson = [
      {
        "id": 1,
        "userId": 123,
        "type": "vacation",
        "startDate": "2021-01-01",
        "endDate": "2021-01-10",
      },
    ];

    when(mockLoader.loadJsonArray(any)).thenAnswer((_) async => mockJson);

    final result = await service.fetchAbsences();

    expect(result, isA<List<AbsenceApiModel>>());
    expect(result.first.id, 1);
    expect(result.first.userId, 123);
  });
}
