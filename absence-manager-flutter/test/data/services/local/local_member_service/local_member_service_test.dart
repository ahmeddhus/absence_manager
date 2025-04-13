import 'package:absence_manager/data/services/api/model/member/member_api_model.dart';
import 'package:absence_manager/data/services/local/local_json_loader.dart';
import 'package:absence_manager/data/services/local/local_member_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([LocalJsonLoader])
import 'local_member_service_test.mocks.dart';

void main() {
  late MockLocalJsonLoader mockLoader;
  late LocalMemberService service;

  setUp(() {
    mockLoader = MockLocalJsonLoader();
    service = LocalMemberService(mockLoader);
  });

  test('fetchMembers returns list of MemberApiModel', () async {
    final mockJson = [
      {"id": 1, "userId": 123, "name": "Test User", "image": "http://example.com"},
    ];

    when(mockLoader.loadJsonArray(any)).thenAnswer((_) async => mockJson);

    final result = await service.fetchMembers();

    expect(result, isA<List<MemberApiModel>>());
    expect(result.first.userId, 123);
    expect(result.first.name, "Test User");
  });
}
