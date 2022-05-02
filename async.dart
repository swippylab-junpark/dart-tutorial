// async and await
const oneSecond = Duration(seconds: 1);

Future<void> printWithDelay(String message) async {
  print(new DateTime.now().toString() + ': $message');
  await Future.delayed(oneSecond);
  print(new DateTime.now().toString() + ': $message');
}

void main(List<String> args) {
  printWithDelay('Hello World!');
}
