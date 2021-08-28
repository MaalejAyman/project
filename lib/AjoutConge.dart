import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Conge.dart';
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
  late List data;
  final String url =
      "https://backend-uniges.pmc.tn/api/ds/formdata?code=DiverSys&val=CONGER01";
  List<DiverSys> parseDiverSys(String responseBody) {
    final parsed =
        jsonDecode(responseBody)["DiverSys"].cast<Map<String, dynamic>>();
    return parsed.map<DiverSys>((json) => DiverSys.fromJson(json)).toList();
  }

  Future<List<DiverSys>> fetchListDiverSys() async {
    final response = await http.Client().get(Uri.parse(url));
    return parseDiverSys(response.body);
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
  void initState() {
    super.initState();
    this.fetchListDiverSys();
  }

  @override
  Widget build(BuildContext context) {
    var currentSelectedValue;
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
                      FutureBuilder<List<DiverSys>>(
                        future: fetchListDiverSys(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('An error has occurred!'),
                            );
                          } else if (snapshot.hasData) {
                            return DropdownButtonFormField(
                              hint: Text("Choisir le type de congé"),
                              value: currentSelectedValue,
                              isDense: true,
                              onChanged: (newValue) {
                                setState(() {
                                  currentSelectedValue = newValue;
                                });
                                print(currentSelectedValue);
                              },
                              items:snapshot.data!
                                  .map<DropdownMenuItem<int>>((DiverSys value) {
                                return DropdownMenuItem<int>(
                                  value: value.Id,
                                  child: Text(value.Titre),
                                );
                              }).toList(),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Date debut :  "),
                          Text("${selectedDateD.toLocal()}".split(' ')[0]),
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
                          Text("${selectedDateF.toLocal()}".split(' ')[0]),
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
                                Login!.Id!,
                                _raisonController.text,
                                selectedDateD,
                                selectedDateF,
                                0);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("congé demandé")),
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
