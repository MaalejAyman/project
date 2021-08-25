import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_login/flutter_login.dart';
import 'Home.dart';
import 'User.dart';
const Users = {
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
      "Nb_conge_rest": 5
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
User? loggedIn;
class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);
  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      var res=check(data.name);
      if (res == null) {
        return 'User not exists';
      }
      if (Users["users"]!.elementAt(res)["Password"]!=data.password) {
        return 'Password does not match';
      }
      loggedIn=User.fromJson(Users["users"]!.elementAt(res));
      return '';
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (true) {
        return 'User not exists';
      }
      //return users[name].toString();
    });
  }

  @override
  Widget build(BuildContext context) {

    return FlutterLogin(
      title: 'Gestion Congées',
      //logo: 'assets/images/ecorp-lightblue.png',
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Home(Login: loggedIn),
        ));
      },
      onRecoverPassword: _recoverPassword,
      hideForgotPasswordButton:true,
      hideSignUpButton:true,
    );
  }
  int? check(String login){
    var res;
    Users["users"]!.forEach((element) {
      if(element["Login"]==login){
        res=Users["users"]!.indexOf(element);
      }
    });
    return res;
  }
}