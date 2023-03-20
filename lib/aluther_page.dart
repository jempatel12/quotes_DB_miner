import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:google_fonts/google_fonts.dart';

import 'global.dart';


class Authors_Page extends StatefulWidget {
  const Authors_Page({super.key});

  @override
  State<Authors_Page> createState() => _Authors_PageState();
}

class _Authors_PageState extends State<Authors_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "QUotes by Authors",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemCount: Globle.authoresList.length,
        separatorBuilder: (context, i) => const Divider(),
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed("Quotes_Description_Page");
            },
            child: Row(
              children: [
                ProfilePicture(
                  name: Globle.authoresList[i].author,
                  radius: 30,
                  fontsize: 20,
                  random: true,
                ),
                const SizedBox(width: 20),
                Text(
                  Globle.authoresList[i].author,
                  style: GoogleFonts.openSans(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
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