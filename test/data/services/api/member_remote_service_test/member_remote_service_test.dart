import 'package:absence_manager/core/network/http_client.dart';
import 'package:absence_manager/data/services/api/member_remote_service.dart';
import 'package:absence_manager/data/services/api/model/member/member_api_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'member_remote_service_test.mocks.dart';

@GenerateMocks([HttpClient])
void main() {
  late MockHttpClient httpClient;
  late MemberRemoteService service;

  setUp(() {
    httpClient = MockHttpClient();
    service = MemberRemoteService(httpClient);
  });

  test('should return parsed list of MemberApiModel when response is valid list', () async {
    final mockResponse = [
      {'userId': 1, 'name': 'Jane Doe', 'image': '', 'id': 101, 'crewId': 1},
    ];

    when(httpClient.get('/members')).thenAnswer((_) async => mockResponse);

    final result = await service.fetchMembers();

    expect(result, isA<List<MemberApiModel>>());
    expect(result.first.userId, 1);
    expect(result.first.name, 'Jane Doe');
  });

  test('should throw FormatException if response is not a list', () async {
    final mockResponse = {'unexpected': 'object'};

    when(httpClient.get('/members')).thenAnswer((_) async => mockResponse);

    expect(() => service.fetchMembers(), throwsA(isA<FormatException>()));
  });
}
