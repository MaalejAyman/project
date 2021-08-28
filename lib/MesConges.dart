import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AjoutConge.dart';
import 'Conge.dart';
import 'LoginInterface.dart';
import 'User.dart';

class MesConge extends StatefulWidget {
  final User? Login;
  const MesConge({Key? key, required this.Login}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MesCongestate(Login);
  }
}

class MesCongestate extends State<MesConge> {
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
        "Id":9,
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
        "Raison": "Ete",
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
        "IsConfirmed": 1,
        "Raison": "Ete",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      }
    ]
  };
  static const List<int> colorCodes = <int>[600, 200];
  static List<Conge> List_CongesWait = [];
  static List<Conge> List_CongesRef = [];
  static List<Conge> List_CongesCon = [];
  MesCongestate(this.Login);
  final User? Login;
  @override
  Widget build(BuildContext context) {
    List_CongesWait = [];
    List_CongesRef = [];
    List_CongesCon = [];
    for (int i = 0; i < Conges["conge"]!.length; i++) {
      Conge c = Conge.fromJson(Conges["conge"]!.elementAt(i));
      if (c.Id_User == Login!.Id) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes Congées"),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("Assets/Image/background.webp"),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("En attentes",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: List_CongesWait.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (List_CongesWait.isNotEmpty) {
                        return InkWell(
                          onTap: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('congé en attente'),
                                content: Text('${List_CongesWait[index].Raison}\n'
                                    'Date debut : ${List_CongesWait[index].Date_Debut!.day}-${List_CongesWait[index].Date_Debut!.month}-${List_CongesWait[index].Date_Debut!.year}\n'
                                    'Date fin :   ${List_CongesWait[index].Date_Fin!.day}-${List_CongesWait[index].Date_Fin!.month}-${List_CongesWait[index].Date_Fin!.year}'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Retour'),
                                    child: const Text('Retour'),
                                  )
                                ],
                              ),
                            );
                          },
                          child: Container(
                            height: 50,
                            color: Colors
                                .amber[colorCodes[index % colorCodes.length]],
                            child: Center(
                                child: Text('${List_CongesWait[index].Raison} : ${List_CongesWait[index].Date_Debut!.day}/${List_CongesWait[index].Date_Debut!.month}/${List_CongesWait[index].Date_Debut!.year} - ${List_CongesWait[index].Date_Fin!.day}/${List_CongesWait[index].Date_Fin!.month}/${List_CongesWait[index].Date_Fin!.year}')),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              Text("Refusés",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: List_CongesRef.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (List_CongesRef.isNotEmpty) {
                        return InkWell(
                          onTap: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('congé refusé'),
                                content: Text('${List_CongesRef[index].Raison}\n'
                                    'Date debut : ${List_CongesRef[index].Date_Debut!.day}-${List_CongesRef[index].Date_Debut!.month}-${List_CongesRef[index].Date_Debut!.year}\n'
                                    'Date fin :   ${List_CongesRef[index].Date_Fin!.day}-${List_CongesRef[index].Date_Fin!.month}-${List_CongesRef[index].Date_Fin!.year}'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Retour'),
                                    child: const Text('Retour'),
                                  )
                                ],
                              ),
                            );
                          },
                          child: Container(
                            height: 50,
                            color: Colors
                                .amber[colorCodes[index % colorCodes.length]],
                            child: Center(
                                child: Text('${List_CongesRef[index].Raison} : ${List_CongesRef[index].Date_Debut!.day}/${List_CongesRef[index].Date_Debut!.month}/${List_CongesRef[index].Date_Debut!.year} - ${List_CongesRef[index].Date_Fin!.day}/${List_CongesRef[index].Date_Fin!.month}/${List_CongesRef[index].Date_Fin!.year}')),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              Text(
                "Acceptés",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: List_CongesCon.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (List_CongesCon.isNotEmpty) {
                        return InkWell(
                          onTap: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('congé accepté'),
                                content: Text('${List_CongesCon[index].Raison}\n'
                                    'Date debut : ${List_CongesCon[index].Date_Debut!.day}-${List_CongesCon[index].Date_Debut!.month}-${List_CongesCon[index].Date_Debut!.year}\n'
                                    'Date fin :   ${List_CongesCon[index].Date_Fin!.day}-${List_CongesCon[index].Date_Fin!.month}-${List_CongesCon[index].Date_Fin!.year}'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Retour'),
                                    child: const Text('Retour'),
                                  )
                                ],
                              ),
                            );
                          },
                          child: Container(
                            height: 50,
                            color: Colors
                                .amber[colorCodes[index % colorCodes.length]],
                            child: Center(
                                child: Text('${List_CongesCon[index].Raison} : ${List_CongesCon[index].Date_Debut!.day}/${List_CongesCon[index].Date_Debut!.month}/${List_CongesCon[index].Date_Debut!.year} - ${List_CongesCon[index].Date_Fin!.day}/${List_CongesCon[index].Date_Fin!.month}/${List_CongesCon[index].Date_Fin!.year}')),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ),
              ),
              Container(
                height: 80,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: hasChef(context),
    );
  }
  Widget? hasChef(BuildContext context) {
    if (Login!.Id_Chef != null) {
      return FloatingActionButton(
        onPressed: () => {
          print(this.Login!.Nb_conge_rest),
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
}
