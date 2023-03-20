import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:google_fonts/google_fonts.dart';


import 'global.dart';

class Category_Page extends StatefulWidget {
  const Category_Page({super.key});

  @override
  State<Category_Page> createState() => _Category_PageState();
}

class _Category_PageState extends State<Category_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "QUotes by Category",
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
        itemCount: Globle.categoryList.length,
        separatorBuilder: (context, i) => const Divider(),
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed("Quotes_Description_Page");
            },
            child: Row(
              children: [
                ProfilePicture(
                  name: Globle.categoryList[i],
                  radius: 30,
                  fontsize: 20,
                  random: true,
                ),
                const SizedBox(width: 20),
                Text(
                  Globle.categoryList[i],
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