import 'package:absence_manager/data/repositories/member/member_repository_local.dart';
import 'package:absence_manager/data/services/api/model/member/member_api_model.dart';
import 'package:absence_manager/data/services/local/local_member_service.dart';
import 'package:absence_manager/domain/models/member/member.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([LocalMemberService])
import 'member_local_repository_test.mocks.dart';

void main() {
  late MockLocalMemberService mockService;
  late MemberLocalRepository repository;

  setUp(() {
    mockService = MockLocalMemberService();
    repository = MemberLocalRepository(mockService);
  });

  group('getAllMembers', () {
    test('returns list of Member domain models', () async {
      // Arrange
      final mockApiModels = [
        MemberApiModel(
          id: 1,
          name: "John Doe",
          image: "http://example.com/image.png",
          userId: 123,
          crewId: 1,
        ),
      ];

      when(mockService.fetchMembers()).thenAnswer((_) async => mockApiModels);

      // Act
      final result = await repository.getAllMembers();

      // Assert
      expect(result, isA<List<Member>>());
      expect(result.length, 1);
      final member = result.first;
      expect(member.userId, 123);
      expect(member.name, "John Doe");
      expect(member.imageUrl, "http://example.com/image.png");
    });

    test('returns an empty list when no data available', () async {
      // Arrange
      when(mockService.fetchMembers()).thenAnswer((_) async => []);

      // Act
      final result = await repository.getAllMembers();

      // Assert
      expect(result, isA<List<Member>>());
      expect(result, isEmpty);
    });

    test('handles null fields gracefully', () async {
      // Arrange
      final mockApiModels = [
        MemberApiModel(id: 1, name: null, image: null, userId: 123, crewId: 1),
      ];

      when(mockService.fetchMembers()).thenAnswer((_) async => mockApiModels);

      // Act
      final result = await repository.getAllMembers();

      // Assert
      expect(result.length, 1);
      final member = result.first;
      expect(member.name, "");
      expect(member.imageUrl, "");
    });
  });
}
