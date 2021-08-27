import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Conge.dart';
import 'DiverSys.dart';
import 'DiverSys.dart';
import 'DiverSys.dart';
import 'User.dart';
import 'package:http/http.dart' as http;

class AjoutConge extends StatefulWidget {
  const AjoutConge({Key? key, required this.Login}) : super(key: key);
  final User? Login;
  @override
  AjoutCongestate createState() {
    return AjoutCongestate(Login);
  }
}

class AjoutCongestate extends State<AjoutConge> {
  late Future<List<DiverSys>> Divers;
  Future<List<DiverSys>> fetchListDiverSys() async {
    List<DiverSys> Diver = [];
    final response = await http.get(Uri.parse(
        'https://backend-uniges.pmc.tn/api/ds/formdata?code=DiverSys&val=CONGER01'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var l = json.decode(response.body)["DiverSys"];
      for (int i = 0; i < l.length; i++) {
        var d = DiverSys.fromJson(l.elementAt(i));
        Diver.add(d);
      }
      return Diver;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list');
    }
  }

  final _raisonController = TextEditingController();
  final User? Login;
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDateD = DateTime.now().add(Duration(days: 1));
  DateTime selectedDateF = DateTime.now().add(Duration(days: 2));
  Future<void> _selectDateD(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateD,
        firstDate: DateTime.now().add(Duration(days: 1)),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateD)
      setState(() {
        selectedDateD = picked;
        selectedDateF = selectedDateD.add(Duration(days: 1));
      });
  }

  Future<void> _selectDateF(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateF,
        firstDate: selectedDateF,
        lastDate: DateTime(2101));
    if (picked != null &&
        picked != selectedDateF &&
        picked.difference(selectedDateD).inDays > 0)
      setState(() {
        selectedDateF = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    Divers = fetchListDiverSys();
    return Scaffold(
      appBar: AppBar(
        title: Text("Demander Congé"),
      ),
      body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("Assets/Image/background.webp"),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 300,
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              controller: _raisonController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'raison du congé'),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "S'il vous plait remplir ce champ";
                                }
                                return null;
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Date debut :  "),
                                Text(
                                    "${selectedDateD.toLocal()}".split(' ')[0]),
                                SizedBox(
                                  height: 15.0,
                                ),
                                RaisedButton(
                                  onPressed: () => _selectDateD(context),
                                  child: Icon(Icons.calendar_today_rounded),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Date fin :         "),
                                Text(
                                    "${selectedDateF.toLocal()}".split(' ')[0]),
                                SizedBox(
                                  height: 15.0,
                                ),
                                RaisedButton(
                                  onPressed: () => _selectDateF(context),
                                  child: Icon(Icons.calendar_today_rounded),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  var s = _raisonController.text +
                                      " " +
                                      selectedDateD.toString() +
                                      " " +
                                      selectedDateF.toString();
                                  Conge newConge = Conge(
                                      10,
                                      Login!.Id,
                                      _raisonController.text,
                                      selectedDateD,
                                      selectedDateF,
                                      0);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("congé demandé")),
                                  );
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  AjoutCongestate(this.Login);
}
