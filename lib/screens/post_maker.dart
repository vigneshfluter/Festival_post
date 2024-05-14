import 'dart:io';
import 'dart:ui';

import 'package:festival_post/model/festivals.dart';
import 'package:festival_post/util/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

class PostMaker extends StatefulWidget {
  const PostMaker({super.key});

  @override
  State<PostMaker> createState() => _PostMakerState();
}

class _PostMakerState extends State<PostMaker> {
  Color fontColor = Colors.black;
  Color backgroundColor = Colors.white;
  String backgroundImage = "";
  String font="style2";
  TextEditingController quoteController = TextEditingController();
  GlobalKey repaintBoundry = GlobalKey();

  void contentCopy() async {
    await Clipboard.setData(ClipboardData(text: Global.quote));
  }

  void shareImage() async {
    RenderRepaintBoundary renderRepaintBoundary = repaintBoundry.currentContext!
        .findRenderObject() as RenderRepaintBoundary;

    var image = await renderRepaintBoundary.toImage(pixelRatio: 5);

    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

    Uint8List fetchImage = byteData!.buffer.asUint8List();

    Directory directory = await getApplicationCacheDirectory();

    String path = directory.path;

    File file = File('$path.png');

    file.writeAsBytes(fetchImage);

    ShareExtend.share(file.path, "Image");
  }

  @override
  Widget build(BuildContext context) {
    Festivals data = ModalRoute.of(context)!.settings.arguments as Festivals;

    return Scaffold(
      appBar: AppBar(
        title: Text("${data.name} Post Maker"),
        actions: [
          IconButton(
            onPressed: () {
              contentCopy();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Quote copied"),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.copy),
          ),
          IconButton(
            onPressed: () {
              shareImage();
            },
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {
              fontColor = Colors.black;
              backgroundColor = Colors.white;
              backgroundImage = "";
              Global.quote = "Tap + to add quote";
              setState(() {});
            },
            icon: Icon(Icons.restart_alt),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add Quote"),
                content: TextField(
                  controller: quoteController,
                  decoration: InputDecoration(hintText: "enter your quote"),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Global.quote = quoteController.text;
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Text("Done"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(12),
        child: ListView(
          children: [
            RepaintBoundary(
              key: repaintBoundry,
              child: Card(
                elevation: 8,
                child: Container(
                  alignment: Alignment.center,
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: backgroundColor,
                    image: DecorationImage(
                      image: ExactAssetImage(backgroundImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                        child: Text(
                          Global.quote,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 25,
                            fontFamily: font,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Choose Font Color",
              style: TextStyle(fontSize: 18),
            ),
            Card(
              elevation: 8,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: Colors.primaries.map((e) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          fontColor = e;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: e,
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Choose Background Color",
              style: TextStyle(fontSize: 18),
            ),
            Card(
              elevation: 8,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: Colors.accents.map((e) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          backgroundColor = e;
                          backgroundImage = "";
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: e,
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Choose Background Image",
              style: TextStyle(fontSize: 18),
            ),
            Card(
              elevation: 8,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: data.images.map((e) {
                    return InkWell(
                      onTap: () {
                        backgroundImage = e;
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(e), fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Choose Fonts",
              style: TextStyle(fontSize: 18),
            ),
            Card(
              elevation: 8,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: Global.fonts.map((e) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          font=e;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(5),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          "Aa",
                          style: TextStyle(fontFamily: e),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
