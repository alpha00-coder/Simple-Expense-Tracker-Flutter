import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/MainScreenDashboard.dart';
import 'package:untitled/screens/ViewExpenses.dart';

import '../models/LoginCred.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.credentials}) : super(key: key);
  final Credentials credentials;

  @override
  State<StatefulWidget> createState() {
    return _MainScreen();
  }
}

class _MainScreen extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _bottomWidgets = <Widget>[
    const MainScreenDashboard(),
    const ViewExpenses(),
    const MainScreenDashboard(),
    const MainScreenDashboard(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  child: ListView(
                children: [
                  Text(widget.credentials.email),
                  Text(widget.credentials.password),
                ],
              )),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.apps,
                    color: Colors.white,
                  ),
                  label: "",
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(Icons.widgets, color: Colors.white),
                  label: "",
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet_sharp,
                      color: Colors.white),
                  label: "",
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Icon(Icons.whatshot, color: Colors.white),
                  label: "",
                  backgroundColor: Colors.black),
            ],
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            iconSize: 40,
            onTap: _onItemTapped,
            elevation: 5),
        appBar: AppBar(
          title: const Text("Expense Manager"),
          centerTitle: true,
        ),
        body: Center(child: _bottomWidgets.elementAt(_selectedIndex)),
      ),
    );
  }
}
