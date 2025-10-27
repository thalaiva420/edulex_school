import 'package:flutter/material.dart';

class Banking extends StatelessWidget{
  const Banking ({super.key});

  @override
  Widget build(BuildContext context){
    return Center(
      child: Text("Banking",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24
      ),),
    );
  }
}