import 'dart:convert';
import 'dart:io';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();

Object decodeFixture(String name) => jsonDecode(fixture(name));
