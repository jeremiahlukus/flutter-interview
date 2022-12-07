import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final config = {
    'environment': Platform.environment['OTTO_ENVIRONMENT'],
    'baseUrl': Platform.environment['OTTO_BASE_URL'],
  };

  const filename = 'lib/.env.dart';
  File(filename).writeAsString('final environment = ${json.encode(config)};');
}
