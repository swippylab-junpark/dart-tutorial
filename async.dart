import 'dart:io';

import 'class.dart';

// async and await
const oneSecond = Duration(seconds: 1);

Future<void> printWithDelay(String message) async {
  print(new DateTime.now().toString() + ': $message');
  await Future.delayed(oneSecond);
  print(new DateTime.now().toString() + ': $message');
}

// no callback hell
Future<void> createDescriptions(Iterable<String> objects) async {
  for (final object in objects) {
    try {
      var file = File('$object.txt');
      if (await file.exists()) {
        var modified = await file.lastModified();
        print('File for $object already exists. It was modified on $modified.');
        continue;
      }
      await file.create();
      await file.writeAsString('Start describing $object in this file.');
    } on IOException catch (e) {
      print('Cannot create description for $object: $e');
    }
  }
}

// stream
Stream<String> report(Spacecraft craft, Iterable<String> objects) async* {
  for (final object in objects) {
    await Future.delayed(oneSecond);
    yield '${craft.name} files by $object';
  }
}

void main(List<String> args) async {
  Stream<String> r =
      report(new Spacecraft.unlaunched('Voyager'), ['hello', 'world']);

  // use Stream api
  r.listen((event) {
    print(event);
  });

  // // use await for
  // await for (final o in r) {
  //   print(o);
  // }
}
