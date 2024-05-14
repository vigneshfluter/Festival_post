import 'package:festival_post/model/festivals.dart';
import 'package:festival_post/util/festival_data.dart';
import 'package:flutter/material.dart';

import '../util/global.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Global.festivals=allFestivals.map((e) => Festivals.fromMap(e)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Festivals",style: TextStyle(fontSize: 30),),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        alignment: Alignment.topCenter,
        child: ListView(
          children: Global.festivals.map((e) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, "postmaker",arguments: e);
              },
              child: Card(
                elevation: 12,
                child: Container(
                  height: 100,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Card(
                        margin: EdgeInsets.all(10),
                        child: Container(
                          width: 130,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          child: Image.asset(
                            e.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            e.name,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
