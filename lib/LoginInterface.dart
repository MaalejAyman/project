import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'Home.dart';
import 'User.dart';
import 'package:http/http.dart' as http;
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
      "Nb_conge_rest": 1,
      "Id_Chef":0
    }
  ]
};
User? loggedIn;
class LoginScreen extends StatelessWidget {
  final String url =
      "https://backend-uniges.pmc.tn/api/users/login";
  Duration get loginTime => Duration(milliseconds: 2500);
  Future<String?> _authUser(LoginData data) {
    var body = jsonEncode( {
      'username': data.name,
      'password': data.password
    });
    Future<User?> fetchLogin() async {
      try {
        final response = await http.Client().post(Uri.parse(url),
            body: body, headers: {
              "Accept": "application/json",
              "content-type": "application/json"
            });
        if (!response.body.contains("Failure")) {
          final parsed =
          jsonDecode(response.body);
          var u = User.fromJson(parsed);
          return User(
              0233,
              data.name,
              "b",
              "c",
              "d",
              1,
              10,
              u.Token);
        } else {
          return null;
        }
      }on SocketException catch (_) {
        return User(
            -1,
            "",
            "",
            "",
            "",
            -1,
            -1,
            "null");
      }
    }
    return Future.delayed(loginTime).then((_) async {
      final User? u = await fetchLogin();
      if(u!=null){
        if(u.Token!="null") {
          loggedIn = u;
          return '';
        }else{
          return 'Verifier votre connection au serveur !';
        }
      }else{
        return "Utilisateur n'existe pas";
      }
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (true) {
        return 'User not exists';
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return FlutterLogin(
      userValidator: (value){
      if (value!.isEmpty) {
        return 'Invalid Username';
      }
      return null;
    },
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