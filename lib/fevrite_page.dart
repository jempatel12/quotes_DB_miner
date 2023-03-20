import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'global.dart';

class Favorite_Page extends StatefulWidget {
  const Favorite_Page({super.key});

  @override
  State<Favorite_Page> createState() => _Favorite_PageState();
}

class _Favorite_PageState extends State<Favorite_Page> {
  final _random = Random();

  @override
  void initState() {
    super.initState();
    // DBHelper.dbHelper.fetchRecord();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Quotes",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemCount: Globle.favoriteList.length,
        separatorBuilder: (context, i) => const SizedBox(height: 25),
        itemBuilder: (context, i) {
          return Container(
            height: _height * 0.66,
            width: _width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          Globle.imagesRendom[Globle.imagesRendom[i]["id"]]
                          ["image"],
                        ),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      Globle.favoriteList[i],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.image,
                          size: 30,
                          color: Colors.brown,
                        ),
                        onPressed: () {
                          setState(() {
                            if (Globle.imagesRendom[i]["id"] <
                                Globle.imagesRendom.length - 5) {
                              Globle.imagesRendom[i]["id"] += 5;
                            } else {
                              Globle.imagesRendom[i]["id"] = 1;
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.copy_rounded,
                          color: Colors.blue.shade800,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.red.shade800,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.download,
                          color: Colors.green.shade800,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 25,
                        ),
                        onPressed: () {
                          Globle.favoriteList.remove(Globle.favoriteList[i]);


                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}