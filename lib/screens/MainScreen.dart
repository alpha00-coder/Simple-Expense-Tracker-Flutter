import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/MainScreenDashboard.dart';
import 'package:untitled/screens/ViewExpenses.dart';

class MainScreen extends StatefulWidget {
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
