import 'dart:io';

String fixiture(String name) =>
    File("test/core/fixtures/$name").readAsStringSync();
