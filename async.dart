import 'dart:io';

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

void main(List<String> args) {
  createDescriptions(['hello', 'world']);
}
