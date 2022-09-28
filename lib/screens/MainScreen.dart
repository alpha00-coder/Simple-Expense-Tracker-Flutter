import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/MainScreenDashboard.dart';
import 'package:untitled/screens/ViewExpenses.dart';

import '../models/LoginCred.dart';
import 'ExpenseCharts.dart';

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
    ExpenseCharts(true)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  ),
                  label: "",),
              BottomNavigationBarItem(
                  icon: Icon(Icons.widgets),
                  label: "",
                 ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet_sharp,
                      ),
                  label: "",
                 ),
            ],
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.blue,
            onTap: _onItemTapped,
            elevation: 0),
        appBar: AppBar(
          title: const Text("Expense Manager"),
          centerTitle: true,
        ),
        body: Center(child: _bottomWidgets.elementAt(_selectedIndex)),

    );
  }
}
