import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/AjoutConge.dart';
import 'package:project/MesConges.dart';
import 'Conge.dart';
import 'LoginInterface.dart';
import 'User.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.Login}) : super(key: key);
  final Login;
  @override
  State<StatefulWidget> createState() {
    return HomeState(Login);
  }
}

class HomeState extends State<Home> {
  static const String _title = 'Gestion des Congées';
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
        "Id_User": 1,
        "IsConfirmed": 0,
        "Raison": "Travel",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      },
      {
        "Id": 2,
        "Id_User": 2,
        "IsConfirmed": 0,
        "Raison": "Ete",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      },
      {
        "Id": 3,
        "Id_User": 2,
        "IsConfirmed": 0,
        "Raison": "Ete",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      },
      {
        "Id": 4,
        "Id_User": 2,
        "IsConfirmed": 0,
        "Raison": "Ete",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      },
      {
        "Id": 5,
        "Id_User": 2,
        "IsConfirmed": 1,
        "Raison": "Ete",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      },
      {
        "Id": 6,
        "Id_User": 2,
        "IsConfirmed": 0,
        "Raison": "Ete",
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
        "Nom": "Mariem",
        "Prenom": "Glaa",
        "Login": "ayman.maalej@esprit.tn",
        "Password": "44914395",
        "Nb_conge_rest": 10,
        "Id_Chef": 1
      }
    ]
  };
  static const List<int> colorCodes = <int>[600, 200];
  static List<Conge> List_Conges = [];
  static List<User> List_Users = [];
  final User? Login;
  var c;
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
          getUserWithId(c.Id_User).Id_Chef == loggedIn!.Id) {
        List_Conges.add(c);
      }
    }
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title),
          actions: [
            Theme(
              data: Theme.of(context).copyWith(
                  textTheme: TextTheme().apply(bodyColor: Colors.blue),
                  dividerColor: Colors.blueAccent,
                  iconTheme: IconThemeData(color: Colors.white)),
              child: PopupMenuButton<int>(
                color: Colors.white,
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                      value: 0,
                      child: Text(
                        "Mes congées",
                        style: TextStyle(color: Colors.blue),
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
                            "Logout",
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      )),
                ],
                onSelected: (item) => SelectedItem(context, item,Login),
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
                              "Bonjour " + Login!.Prenom + " " + Login!.Nom,
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
                                  title: const Text('confirmer congé'),
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
                                          child: const Text('refuser'),
                                        ),
                                        TextButton(
                                          onPressed: () => setState(() => {
                                                changeCongestateConf(
                                                    List_Conges[index],
                                                    List_Conges),
                                                Navigator.pop(
                                                    context, 'Confirmer'),
                                              }),
                                          child: const Text('Confirmer'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Retour'),
                                          child: const Text('Retour'),
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
                                      '${getUserWithId(List_Conges[index].Id_User).Nom} ${getUserWithId(List_Conges[index].Id_User).Prenom} : "${List_Conges[index].Raison}"')),
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
              ],
            ),
          ),
        ),
        floatingActionButton: hasChef(context),
      ),
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

  HomeState(this.Login);
}

void SelectedItem(BuildContext context, item,User? Login) {
  switch (item) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MesConge(Login: Login)));
      break;
    case 1:
      print("User Logged out");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
      break;
  }
}

void changeCongestateRef(Conge c, List<Conge> con) {
  //con.remove(c);
}

void changeCongestateConf(Conge c, List<Conge> con) {
  //con.remove(c);
}
