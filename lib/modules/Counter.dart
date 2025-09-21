import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  var counter = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CounterScreen();
  }

  CounterScreen() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text('You have pushed the button this many times:'),
      Text("$counter"),
      TextButton(
        onPressed: () {
          setState(() {
            counter++;
          });
        },
        child: Text("press here"),
      ),
    ],
  );
}
