import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Conge.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.CongePressed}) : super(key: key);
  final Conge CongePressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CongePressed.Id.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(CongePressed.Date_Debut.toString()),
      ),
    );
  }
}