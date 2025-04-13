import 'package:absence_manager/core/network/http_client.dart';
import 'package:absence_manager/data/services/api/absence_remote_service.dart';
import 'package:absence_manager/data/services/api/model/absence/absence_api_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'absence_remote_service_test.mocks.dart';

@GenerateMocks([HttpClient])
void main() {
  late MockHttpClient httpClient;
  late AbsenceRemoteService service;

  setUp(() {
    httpClient = MockHttpClient();
    service = AbsenceRemoteService(httpClient);
  });

  test('should fetch absences and return parsed total + list', () async {
    final mockResponse = {
      'total': 1,
      'data': [
        {
          'id': 1,
          'userId': 10,
          'type': 'vacation',
          'startDate': '2024-01-01',
          'endDate': '2024-01-02',
          'memberNote': null,
          'admitterNote': null,
          'status': 'confirmed',
        },
      ],
    };

    final expectedUri = Uri(path: '/absences', queryParameters: {'page': '1', 'limit': '10'});

    when(httpClient.getUri(expectedUri)).thenAnswer((_) async => mockResponse);

    final (total, items) = await service.fetchAbsences(page: 1, limit: 10);

    expect(total, 1);
    expect(items, isA<List<AbsenceApiModel>>());
    expect(items.first.id, 1);
    expect(items.first.type, 'vacation');
  });

  test('should throw if data format is invalid', () async {
    final mockResponse = {'invalid': true};

    final expectedUri = Uri(path: '/absences', queryParameters: {'page': '1', 'limit': '10'});

    when(httpClient.getUri(expectedUri)).thenAnswer((_) async => mockResponse);

    expect(() => service.fetchAbsences(page: 1, limit: 10), throwsA(isA<TypeError>()));
  });
}
