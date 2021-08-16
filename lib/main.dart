import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:android_projects/app_screens/list.dart';
import 'package:android_projects/app_screens/form.dart';
void main()
{
  runApp(MyApp());
}
class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Movie Roster',
     debugShowCheckedModeBanner: false,
     theme:
       ThemeData(
         primarySwatch : Colors.grey
       ),
   home: MovieList()
   );
  }
}