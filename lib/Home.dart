import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Conge.dart';
import 'LoginInterface.dart';
import 'User.dart';

class Home extends StatelessWidget {
  const Home({Key? key, required this.Login}) : super(key: key);
  static const String _title = 'Home';
  static const Conges = {
    "conge": [
      {
        "Id": 0,
        "Id_User": 0,
        "IsConfirmed": false,
        "Raison": "Maladie",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      },
      {
        "Id": 1,
        "Id_User": 1,
        "IsConfirmed": false,
        "Raison": "Travel",
        "DateDebut": "2020-07-10 15:00:00.000",
        "DateFin": "2020-07-10 15:00:00.000"
      },
      {
        "Id": 2,
        "Id_User": 2,
        "IsConfirmed": false,
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
        "Id_Chef":1
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
        "Nb_conge_rest": 0,
        "Id_Chef":0
      }
    ]
  };
  static const List<String> CList = ["a", "b", "c"];
  static const List<int> colorCodes = <int>[600, 500, 100];
  static List<Conge> List_Conges=[];
  static List<User> List_Users=[];
  final User? Login;

  @override
  Widget build(BuildContext context) {
    List_Conges=[];
    List_Users=[];
    for (int i = 0; i < Users["users"]!.length; i++) {
      List_Users.add(User.fromJson(Users["users"]!.elementAt(i)));
    }
    for (int i = 0; i < Conges["conge"]!.length; i++) {
      var c =Conge.fromJson(Conges["conge"]!.elementAt(i));
      if(!c.IsConfirmed && getUserWithId(c.Id_User).Id_Chef==loggedIn!.Id) {
        List_Conges.add(c);
      }
    }

    print(List_Conges.length);
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
        body: SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("Assets/Image/background.webp"),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 360,
                      height: 65,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 9.0),
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 8.0),
                        child: Text(
                          "Bonjour Mr " + Login!.Prenom + " " + Login!.Nom,
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
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
                Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height - 160,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: List_Conges.length,
                    itemBuilder: (BuildContext context, int index) {
                      if(List_Conges.isNotEmpty) {
                        return Container(
                          height: 50,
                          color: Colors.amber[colorCodes[index]],
                          child: Center(
                              child: Text('${getUserWithId(List_Conges[index].Id_User).Nom} ${getUserWithId(List_Conges[index].Id_User).Prenom} : "${List_Conges[index].Raison}"')),
                        );
                      }else{
                        return Container();
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: hasChef(),
      ),
    );
  }
  User getUserWithId(int id){
    var res = null;
    List_Users.forEach((element) {
      if(element.Id==id){
        res = element;
      }
    });
    return res;
  }
  Widget? hasChef(){
    if(loggedIn!.Id_Chef!=null){
      return FloatingActionButton(
        onPressed: () => {},
        elevation: 10,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30.0,
        ),
      );
    }else{
      return null;
    }
  }
}

