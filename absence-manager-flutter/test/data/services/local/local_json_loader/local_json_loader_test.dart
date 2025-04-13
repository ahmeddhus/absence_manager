import 'package:absence_manager/data/services/local/local_json_loader.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([AssetBundle])
import 'local_json_loader_test.mocks.dart';

void main() {
  late MockAssetBundle mockBundle;
  late LocalJsonLoader loader;

  setUp(() {
    mockBundle = MockAssetBundle();
    loader = LocalJsonLoader(bundle: mockBundle);
  });

  test('loads and parses JSON array under "payload" key', () async {
    const jsonStr = '''
      {
        "message": "Success",
        "payload": [
          { "id": 1, "name": "Test" }
        ]
      }
    ''';

    when(mockBundle.loadString('assets/json/fake.json')).thenAnswer((_) async => jsonStr);

    final result = await loader.loadJsonArray('assets/json/fake.json');

    expect(result, isA<List<dynamic>>());
    expect(result.first['id'], 1);
    expect(result.first['name'], 'Test');
  });

  test('throws FormatException if "payload" key is missing', () async {
    const invalidJson = '{"noPayload": []}';

    when(mockBundle.loadString('assets/json/invalid.json')).thenAnswer((_) async => invalidJson);

    expect(
      () async => await loader.loadJsonArray('assets/json/invalid.json'),
      throwsA(isA<FormatException>()),
    );
  });
}
