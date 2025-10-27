import 'package:flutter/material.dart';

class Attendance extends StatelessWidget{
  const Attendance({super.key});
  @override
  Widget build(BuildContext context){
    return Center(
      child: Text(
        "Attendance",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}