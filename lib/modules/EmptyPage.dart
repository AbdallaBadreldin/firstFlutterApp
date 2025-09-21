import 'package:flutter/cupertino.dart';

class EmptyPage extends StatefulWidget {
  const EmptyPage({super.key});

  @override
  State<EmptyPage> createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    // var dataString = await getString();
    // var dataInt = await getName();
    return Text("Static String");
  }

  Future<String> getString() =>
      Future.delayed(Duration(seconds: 2), () => "Hello");

  Future<int> getInt() => Future(() => 10);

  Future<String> getName() async {
    return "TheBoSs";
  }
}
