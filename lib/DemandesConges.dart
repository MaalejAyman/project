import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AjoutConge.dart';
import 'Conge.dart';
import 'LoginInterface.dart';
import 'MesConges.dart';
import 'User.dart';

class DemandesConges extends StatefulWidget {
  final User? Login;
  const DemandesConges({Key? key, required this.Login}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return DemandesCongesstate(Login);
  }

}
class DemandesCongesstate extends State<DemandesConges> {
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
  static const Users = {
    "users": [
      {
        "Id": 0,
        "Nom": "Ayman",
        "Prenom": "Maalej",
        "Login": "mimox07@gmail.com",
        "Password": "12345",
        "Nb_conge_rest": 10,
        "Id_Chef": 1
      },
      {
        "Id": 1,
        "Nom": "Anas",
        "Prenom": "Zitoun",
        "Login": "maalej.ayman98@gmail.com",
        "Password": "20914395",
        "Nb_conge_rest": 5,
      },
      {
        "Id": 2,
        "Nom": "Amine",
        "Prenom": "Mami",
        "Login": "ayman.maalej@esprit.tn",
        "Password": "44914395",
        "Nb_conge_rest": 10,
        "Id_Chef": 0
      },
      {
        "Id": 3,
        "Nom": "Mariem",
        "Prenom": "Glaa",
        "Login": "Test",
        "Password": "44914395",
        "Nb_conge_rest": 2,
        "Id_Chef": 0
      }
    ]
  };
  static const List<int> colorCodes = <int>[600, 200];
  static List<Conge> List_Conges = [];
  static List<User> List_Users = [];
  final User? Login;
  var c;
  DemandesCongesstate(this.Login);
  @override
  Widget build(BuildContext context) {
    List_Conges = [];
    List_Users = [];
    for (int i = 0; i < Users["users"]!.length; i++) {
      List_Users.add(User.fromJson(Users["users"]!.elementAt(i)));
    }
    for (int i = 0; i < Conges["conge"]!.length; i++) {
      c = Conge.fromJson(Conges["conge"]!.elementAt(i));
      if (c.IsConfirmed == 0 &&
          getUserWithId(c.Id_User).Id_Chef == Login!.Id) {
        List_Conges.add(c);
      }
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
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
                  flex: 9,
                  child: Container(
                    color: Colors.transparent,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: List_Conges.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (List_Conges.isNotEmpty) {
                          return InkWell(
                            onTap: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Retour'),
                                        icon: Icon(Icons.arrow_back),
                                      ),
                                      Text('confirmer congé'),
                                    ],
                                  ),
                                  content: Text(
                                      '${getUserWithId(List_Conges[index].Id_User).Nom} ${getUserWithId(List_Conges[index].Id_User).Prenom} : "${List_Conges[index].Raison}"\n'
                                          'Date debut : ${List_Conges[index].Date_Debut!.day}-${List_Conges[index].Date_Debut!.month}-${List_Conges[index].Date_Debut!.year}\n'
                                          'Date fin :   ${List_Conges[index].Date_Fin!.day}-${List_Conges[index].Date_Fin!.month}-${List_Conges[index].Date_Fin!.year}'),
                                  actions: <Widget>[
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: () => setState(() => {
                                            changeCongestateRef(
                                                List_Conges[index],
                                                List_Conges),
                                            Navigator.pop(
                                                context, 'refuser')
                                          }),
                                          child: const Icon(Icons.close,color: Colors.red,),
                                        ),
                                        TextButton(
                                          onPressed: () => setState(() => {
                                            changeCongestateConf(
                                                List_Conges[index],
                                                List_Conges),
                                            Navigator.pop(
                                                context, 'Confirmer'),
                                          }),
                                          child: Icon(Icons.check,color: Colors.green,),
                                        ),
                                      ],
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                  child: Text(
                                      '${getUserWithId(List_Conges[index].Id_User).Nom} ${getUserWithId(List_Conges[index].Id_User).Prenom} | Raison : "${List_Conges[index].Raison}"')),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                        color: Colors.white,
                      ),
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

  User getUserWithId(int id) {
    var res = null;
    List_Users.forEach((element) {
      if (element.Id == id) {
        res = element;
      }
    });
    return res;
  }

  Widget? hasChef(BuildContext context) {
    if (loggedIn!.Id_Chef != null) {
      return FloatingActionButton(
        onPressed: () => {
          print(this.Login!.Nb_conge_rest),
          if (this.Login!.Nb_conge_rest > 0)
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
void changeCongestateRef(Conge c, List<Conge> con) {
  //con.remove(c);
}

void changeCongestateConf(Conge c, List<Conge> con) {
  //con.remove(c);
}