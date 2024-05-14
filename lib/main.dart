import 'package:festival_post/screens/home_page.dart';
import 'package:festival_post/screens/post_maker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "style2",
      ),
      routes: {
        "/":(context) =>HomePage(),
        "postmaker":(context) => PostMaker(),
      },
    ),
  );
}
