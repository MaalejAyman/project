import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/AjoutConge.dart';
import 'package:project/DemandesConges.dart';
import 'package:project/MesConges.dart';
import 'Conge.dart';
import 'LoginInterface.dart';
import 'User.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key, required this.Login}) : super(key: key);
  final Login;
  @override
  State<StatefulWidget> createState() {
    return HomeState(Login);
  }
}

class HomeState extends State<Home> {
  static List<Conge> List_CongesWait = [];
  static List<Conge> List_CongesRef = [];
  static List<Conge> List_CongesCon = [];
  static const String _title = 'Gestion des Congés';
  static const Conges = {
    "conge": [
      {
        "Id": 0,
        "Id_User": 0,
        "IsConfirmed": 0,
        "Raison": "Maladie",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      },
      {
        "Id": 1,
        "Id_User": 0,
        "IsConfirmed": 0,
        "Raison": "Maladie",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      },
      {
        "Id": 2,
        "Id_User": 0,
        "IsConfirmed": 0,
        "Raison": "Maladie",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      },
      {
        "Id": 3,
        "Id_User": 0,
        "IsConfirmed": 0,
        "Raison": "Maladie",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      },
      {
        "Id": 4,
        "Id_User": 0,
        "IsConfirmed": 0,
        "Raison": "Maladie",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      },
      {
        "Id": 5,
        "Id_User": 0,
        "IsConfirmed": 1,
        "Raison": "Maladie",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      },
      {
        "Id": 6,
        "Id_User": 0,
        "IsConfirmed": 2,
        "Raison": "Maladie",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      },
      {
        "Id": 7,
        "Id_User": 1,
        "IsConfirmed": 0,
        "Raison": "Travel",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      },
      {
        "Id": 8,
        "Id_User": 2,
        "IsConfirmed": 0,
        "Raison": "Ete",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      },
      {
        "Id": 9,
        "Id_User": 2,
        "IsConfirmed": 0,
        "Raison": "Ete",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      },
      {
        "Id": 10,
        "Id_User": 2,
        "IsConfirmed": 0,
        "Raison": "familiale",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      },
      {
        "Id": 11,
        "Id_User": 2,
        "IsConfirmed": 1,
        "Raison": "Ete",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      },
      {
        "Id": 12,
        "Id_User": 3,
        "IsConfirmed": 0,
        "Raison": "covid",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      }
    ]
  };
  static const List<int> colorCodes = <int>[600, 200];
  static List<Conge> List_Conges = [];
  List<Conge> List_CongesOwn = [];
  final User? Login;
  var c;
  String urlFetchOwnConge =
      "https://backend-uniges.pmc.tn/api/recherche/tbdata?tablere=avtConge";
  @override
  void initState() {
    List_CongesOwn = [];
    super.initState();
    Updatelist();
  }
  Future<void> Updatelist() async {
    this.List_CongesOwn = (await this.fetchListOwnConge());
    InitListConge();
  }
  Future<List<Conge>> fetchListOwnConge() async {
      final response = await http.Client().get(Uri.parse(urlFetchOwnConge),
          headers: {"Authorization": "Bearer " + Login!.Token});
      return await parseConge(response.body);
  }
  Future<List<Conge>> parseConge(String body) async {
    final parsed = jsonDecode(body).cast<Map<String, dynamic>>();
    return await parsed.map<Conge>((json) => Conge.fromJson(json)).toList();
  }
  @override
  Widget build(BuildContext context) {
    Updatelist();
    List_Conges = [];
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.home),
              Text("   "+_title),
            ],
          ),
          actions: [
            IconButton(onPressed: (){
                setState(() {
                  Updatelist();
                });
            }, icon: Icon(Icons.refresh)),
            Theme(
              data: Theme.of(context).copyWith(
                  textTheme: TextTheme().apply(bodyColor: Colors.blue),
                  dividerColor: Colors.blueAccent,
                  iconTheme: IconThemeData(color: Colors.white)),
              child: PopupMenuButton<int>(
                color: Colors.white,
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: [
                          Icon(
                            Icons.folder,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Demandes Congés",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      )),
                  PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                        children: [
                          Icon(
                            Icons.folder,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Mes congés",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      )),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "se déconnecter",
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      )),
                ],
                onSelected: (item) => SelectedItem(context, item, Login,List_CongesCon,List_CongesRef,List_CongesWait),
              ),
            ),
          ],
        ),
        body: SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("Assets/Image/background.webp"),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 360,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 9.0),
                          padding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 8.0),
                          child: Center(
                            child: Text(
                              "Bonjour " + Login!.Login!,
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blueAccent),
                                elevation:
                                    MaterialStateProperty.all<double>(100),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        MesConge(Login: Login,List_CongesCon: List_CongesCon,List_CongesRef: List_CongesRef,List_CongesWait: List_CongesWait,)));
                              },
                              child: Container(
                                child: SizedBox.expand(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Mes Congés",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40,
                                          ),
                                        ),
                                        Divider(
                                          indent: 70,
                                          endIndent: 70,
                                          color: Colors.white,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("En attente : " +
                                                List_CongesWait.length
                                                    .toString() +
                                                ""),
                                            Text("Refusés     : " +
                                                List_CongesRef.length
                                                    .toString() +
                                                ""),
                                            Text("Acceptés   : " +
                                                List_CongesCon.length
                                                    .toString() +
                                                ""),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 40,
                            color: Colors.white,
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blueAccent),
                                elevation:
                                    MaterialStateProperty.all<double>(100),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        DemandesConges(Login: Login)));
                              },
                              child: Container(
                                child: SizedBox.expand(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Demandes Congés",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40,
                                          ),
                                        ),
                                        Divider(
                                          indent: 20,
                                          endIndent: 20,
                                          color: Colors.white,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("En attente : " +
                                                List_Conges.length.toString() +
                                                ""),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: hasChef(context),
      ),
    );
  }

  /*User getUserWithId(int id) {
    var res = null;
    List_Users.forEach((element) {
      if (element.Id == id) {
        res = element;
      }
    });
    return res;
  }*/

  Widget? hasChef(BuildContext context) {
    if (loggedIn!.Id_Chef != null) {
      return FloatingActionButton(
        onPressed: () => {
          if (this.Login!.Nb_conge_rest! > 0)
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AjoutConge(Login: this.Login)),
              )
            }
          else
            {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Solde Congé epuisé'),
                  content: const Text("vous n'avez plus de jours de congés"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              )
            }
        },
        elevation: 10,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30.0,
        ),
      );
    } else {
      return null;
    }
  }

  void InitListConge() {
    List_CongesWait = [];
    List_CongesRef = [];
    List_CongesCon = [];
    for (int i = 0; i < List_CongesOwn.length; i++) {
      Conge c = List_CongesOwn.elementAt(i);
      switch (c.IsConfirmed) {
        case 0:
          {
            List_CongesWait.add(c);
          }
          break;
        case 1:
          {
            List_CongesCon.add(c);
          }
          break;
        case 2:
          {
            List_CongesRef.add(c);
          }
          break;
        default:
          {}
          break;
      }
    }
  }

  HomeState(this.Login);
}

void SelectedItem(BuildContext context, item, User? Login,List_CongesCon,List_CongesRef,List_CongesWait) {
  switch (item) {
    case 0:
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => MesConge(Login: Login,List_CongesCon: List_CongesCon,List_CongesRef: List_CongesRef,List_CongesWait: List_CongesWait,)));
      break;
    case 1:
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('se déconnecter'),
          content: Text("voulez vous vraiment déconnecter ?"),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Retour'),
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () => {
                    Navigator.pop(context, 'oui'),
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false)
                  },
                  child: const Text('oui'),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            )
          ],
        ),
      );
      break;
    case 2:
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DemandesConges(Login: Login)));
      break;
  }
}

void changeCongestateRef(Conge c, List<Conge> con) {
  //con.remove(c);
}

void changeCongestateConf(Conge c, List<Conge> con) {
  //con.remove(c);
}
