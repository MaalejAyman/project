import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'LoginInterface.dart';
import 'User.dart';

class Home extends StatelessWidget {
  const Home({Key? key, required this.Login}) : super(key: key);
  static const String _title = 'Home';
  static const List<String> CList = ["a", "b", "c"];
  final User? Login;
  static List<Widget> CList_widget = [];
  @override
  Widget build(BuildContext context) {
    CList_widget = [];
    for (int i = 0; i < CList.length; i++) {
      CList_widget.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              CList.elementAt(i),
            ),
          )
        ],
      ));
    }
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_title),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ],
        )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Bonjour, " + Login!.Prenom + " " + Login!.Nom,
            style: TextStyle(
              color: Colors.black.withOpacity(1.0),
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 59,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          elevation: 10,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30.0,
          ),
        ),
      ),
    );
  }
}
