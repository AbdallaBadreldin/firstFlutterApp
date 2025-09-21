import 'dart:core';
import 'dart:io';

import 'package:first/modules/Counter.dart';
import 'package:first/modules/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import for FFI
import 'EmptyPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) { // Optional: Condition for desktop
    sqfliteFfiInit(); // Initialize FFI
    databaseFactory = databaseFactoryFfi; // Assign the FFI database factory
  }
  var mainScreen = MainScreen();
  runApp(mainScreen);
}

class MainScreen extends StatefulWidget {

  static const String routeHome = "/homeScreen";
  static const String routeCounter = "/counterScreen";
  static const String routeEmpty = "/emptyScreen";

  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen>  with WidgetsBindingObserver{
  Database? _db;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Register observer
    _openAppDatabase();
  }

  Future<void> _openAppDatabase() async {
    // Check if DatabaseHelper.dart is already open to avoid re-opening
    if (_db == null || !_db!.isOpen) {
      print("DatabaseHelper.dart: Opening my_db.db in MainScreen");
      _db = await openDatabase('my_db.db'); // Assign to _db
      print("DatabaseHelper.dart: my_db.db opened in MainScreen");
      // You can perform initial setup here if needed
      // await _db?.execute('CREATE TABLE IF NOT EXISTS MyTable (id INTEGER PRIMARY KEY, name TEXT)');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Don't forget to remove
    // Close DatabaseHelper.dart when the widget is disposed. This is important for widget lifecycle.
    _closeAppDatabase("MainScreen dispose");
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('MainScreen AppLifecycleState: $state');
    if (state == AppLifecycleState.detached || state == AppLifecycleState.paused) {
      _closeAppDatabase("App ${state.name}");
    } else if (state == AppLifecycleState.resumed) {
      // If you close on paused, you might want to reopen on resumed
      _openAppDatabase();
    }
  }
  Future<void> _closeAppDatabase(String from) async {
    if (_db != null && _db!.isOpen) {
      print("DatabaseHelper.dart: Closing my_db.db from $from");
      await _db?.close();
      _db = null; // Important to set to null after closing
      print("DatabaseHelper.dart: my_db.db closed from $from");
    } else {
      print("DatabaseHelper.dart: my_db.db already closed or not initialized when trying to close from $from");
    }
  }
  var pageIndex = 0;

  Map<String, WidgetBuilder> listOfRoutes = {
    MainScreen.routeHome: (context) => HomeScreen(),
    MainScreen.routeCounter: (context) => Counter(),
    MainScreen.routeEmpty: (context) => EmptyPage(),
  };

  var listOfWidgets = [HomeScreen(), Counter(), EmptyPage()];

  var listOfTitles = ["Home", "Counter", "Empty"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      title: listOfTitles[pageIndex],
      color: Colors.black,
      home: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          elevation: 10,
          selectedFontSize: 15,
          unselectedFontSize: 15,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          selectedIconTheme: IconThemeData(size: 30),
          unselectedIconTheme: IconThemeData(size: 30),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
              backgroundColor: Colors.blue,
            ),
          ],
          currentIndex: pageIndex,
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
            print(index);
          },
        ),
        appBar: AppBar(
          leading: Icon(Icons.abc),
          title: Text(listOfTitles[pageIndex]),
          centerTitle: true,
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: listOfWidgets[pageIndex],
      ),
    );
  }
}
