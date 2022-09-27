import 'package:flutter/material.dart';
import 'package:untitled/models/LoginCred.dart';
import 'package:untitled/screens/AddProducts.dart';

import 'ViewExpenses.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.credentials}) : super(key: key);

  final Credentials credentials;

  @override
  State<StatefulWidget> createState() {
    return _Dashboard();
  }
}

class _Dashboard extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: MaterialApp(
            home: Scaffold(
          appBar: AppBar(
            title: const Text("Dashboard"),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.contacts), text: "Tab 1"),
                Tab(icon: Icon(Icons.camera_alt), text: "Tab 2")
              ],
            ),
          ),
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
          body: const TabBarView(
            children: [
              AddProducts(),
              ViewExpenses(),
            ],
          ),
        )));
  }
}
