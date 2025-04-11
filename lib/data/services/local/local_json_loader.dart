import 'dart:convert';

import 'package:flutter/services.dart';

class LocalJsonLoader {
  const LocalJsonLoader();

  Future<List<dynamic>> loadJsonArray(String assetPath, {String arrayKey = 'payload'}) async {
    final jsonString = await rootBundle.loadString(assetPath);
    final decoded = json.decode(jsonString) as Map<String, dynamic>;

    if (decoded[arrayKey] is List<dynamic>) {
      return decoded[arrayKey];
    } else {
      throw FormatException('Expected a List under key "$arrayKey"');
    }
  }
}
