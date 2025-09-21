import 'package:first/modules/Counter.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}); //key constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentGeometry.center,
      color: Colors.amber,
      height: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              alignment: AlignmentGeometry.center,
              child: Text("data1"),
            ),
          ),
          Expanded(
            child: Container(
              alignment: AlignmentGeometry.center,
              child: Text("data2"),
            ),
          ),
          Expanded(
            child: Container(
              alignment: AlignmentGeometry.center,
              child: Text("data3"),
            ),
          ),
          Expanded(
            child: Container(
              alignment: AlignmentGeometry.center,
              child: Text("data4"),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                  MaterialPageRoute(builder: (context) => const Counter())
              );
            },
            child: Text("press here to go to Counter page"),
          ),
        ],
      ),
    );
  }
}
