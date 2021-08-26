import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'User.dart';

class AjoutConge extends StatefulWidget {
  const AjoutConge({Key? key, required this.Login}) : super(key: key);
  final User? Login;
  @override
  AjoutCongestate createState() {
    return AjoutCongestate(Login);
  }
}

class AjoutCongestate extends State<AjoutConge> {
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
        lastDate: selectedDateD.add(Duration(days: Login!.Nb_conge_rest)));
    if (picked != null &&
        picked != selectedDateF &&
        picked.difference(selectedDateD).inDays > 0)
      setState(() {
        selectedDateF = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
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
              height: 230,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
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
                          Text("${selectedDateD.toLocal()}".split(' ')[0]),
                          SizedBox(
                            height: 15.0,
                          ),
                          RaisedButton(
                            onPressed: () => _selectDateD(context),
                            child: Text('Select date'),
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
                            child: Text('Select date'),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
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
