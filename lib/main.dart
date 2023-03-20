import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app/quptes_page.dart';

import 'aluther_page.dart';
import 'cetegary_page.dart';
import 'fevrite_page.dart';
import 'global.dart';
import 'helper/api_helper.dart';
import 'modal/quotes.dart';


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "Home_Page",
      routes: {
        "/": (context) => const Home_Page(),
        "Quotes_Description_Page": (context) => const Quotes_Description_Page(),
        "Category_Page": (context) => const Category_Page(),
        "Authors_Page": (context) => const Authors_Page(),
        "Favorite_Page": (context) => const Favorite_Page(),
      },
    ),
  );
}

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  late Future<dynamic> api;

  @override
  void initState() {
    super.initState();
    api = ApiHelper.apiHelper.fetchRendomQuotes();
    ApiHelper.apiHelper.fetchQuotes();
  }

  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Life Quotes and ...",
          style: GoogleFonts.openSans(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: Colors.black,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.notification_add),
                color: Colors.amber,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.favorite),
                color: Colors.red,
                onPressed: () {
                  Navigator.of(context).pushNamed("Favorite_Page");
                },
              ),
            ],
          )
        ],
      ),
      drawer: Drawer(
        width: _width * 0.77,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: _height * 0.25,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.redAccent.shade100,
                  ],
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "Life Quotes and Sayings",
                textAlign: TextAlign.center,
                style: GoogleFonts.pacifico(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
            drawerItems(
              name: "By Topic",
              color: Colors.purple,
              icon: const Icon(Icons.topic),
            ),
            drawerItems(
              name: "By Auther",
              color: Colors.red,
              icon: const Icon(Icons.people_alt),
            ),
            drawerItems(
              name: "Favourites",
              color: Colors.amber,
              icon: const Icon(Icons.star),
            ),
            drawerItems(
              name: "Quotes of the day",
              color: Colors.red,
              icon: const Icon(Icons.bubble_chart),
            ),
            drawerItems(
              name: "Favourite Pictures",
              color: Colors.amber,
              icon: const Icon(Icons.star),
            ),
            drawerItems(
              name: "Videos",
              color: Colors.red,
              icon: const Icon(Icons.videocam_sharp),
            ),
            Divider(
              color: Colors.black.withOpacity(0.2),
              height: 40,
              thickness: 1,
            ),
            Text(
              "    Communicate",
              style: GoogleFonts.openSans(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            drawerItems(
              name: "Settings",
              color: Colors.black,
              icon: const Icon(Icons.settings),
            ),
            drawerItems(
              name: "Share",
              color: Colors.black,
              icon: const Icon(Icons.share),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: api,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("ERROR : ${snapshot.error}");
          } else if (snapshot.hasData) {
            List<Quotes> data = snapshot.data;

            List slider = [
              Globle.imagesRendom[10]["image"],
              Globle.imagesRendom[11]["image"],
              Globle.imagesRendom[12]["image"],
              Globle.imagesRendom[13]["image"],
              Globle.imagesRendom[14]["image"],
            ];

            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(10),
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayAnimationDuration:
                    const Duration(milliseconds: 700),
                    autoPlayCurve: Curves.easeInOut,
                    autoPlayInterval: const Duration(seconds: 10),
                    scrollPhysics: const BouncingScrollPhysics(),
                    viewportFraction: 0.97,
                    initialPage: currentindex,
                    onPageChanged: (val, _) {
                      setState(() {
                        currentindex = val;
                      });
                    },
                    enlargeCenterPage: true,
                  ),
                  items: slider.map((i) {
                    int index = slider.indexOf(i);

                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(i),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 270,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(),
                                Text(
                                  Globle.quotesCategory[index].content,
                                  textAlign: TextAlign.center,
                                  maxLines: 4,
                                  style: GoogleFonts.openSans(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                // AnimatedSmoothIndicator(
                                //   activeIndex: currentindex,
                                //   count: 5,
                                //   effect: SlideEffect(
                                //     dotColor: Colors.white.withOpacity(0.6),
                                //     activeDotColor: Colors.white,
                                //     dotHeight: 7,
                                //     dotWidth: 7,
                                //   ),
                                // ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    categoryTag(
                      color: Colors.red,
                      icon: Icons.category_sharp,
                      name: "Categories",
                    ),
                    categoryTag(
                      color: Colors.purple,
                      icon: Icons.image,
                      name: "Pick Quotes",
                    ),
                    categoryTag(
                      color: Colors.green,
                      icon: Icons.settings,
                      name: "Articles",
                    ),
                    categoryTag(
                      color: Colors.amber.shade800,
                      icon: Icons.architecture,
                      name: "latest Quotes",
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Most Popluar Quotes
                Text(
                  "Most Popular",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    mostPopular(width: _width, name: "Sports Quotes", i: 1),
                    mostPopular(width: _width, name: "Learning Quotes", i: 2),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    mostPopular(width: _width, name: "Love Quotes", i: 3),
                    mostPopular(width: _width, name: "Truth Quotes", i: 4),
                  ],
                ),
                const SizedBox(height: 20),
                // Categories By Quotes
                Row(
                  children: [
                    Text(
                      "Quotes By Category",
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("Category_Page");
                      },
                      child: Text(
                        "View All >",
                        style: TextStyle(
                          color: Colors.orange.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    mostPopular(
                        width: _width, name: "Inspirational Quotes", i: 5),
                    mostPopular(width: _width, name: "Famous Quotes", i: 6),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    mostPopular(width: _width, name: "Wisdom Quotes", i: 7),
                    mostPopular(width: _width, name: "War Quotes", i: 8),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Quotes By Authors",
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("Authors_Page");
                      },
                      child: Text(
                        "View All >",
                        style: TextStyle(
                          color: Colors.orange.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    authorsQuotes(
                      width: _width,
                      color: Colors.amber.shade200,
                      name: Globle.authoresList[0].author,
                    ),
                    authorsQuotes(
                      width: _width,
                      color: Colors.pink.shade100,
                      name: Globle.authoresList[2].author,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    authorsQuotes(
                      width: _width,
                      color: Colors.amber.shade300,
                      name: Globle.authoresList[5].author,
                    ),
                    authorsQuotes(
                      width: _width,
                      color: Colors.cyan.shade100,
                      name: Globle.authoresList[10].author,
                    ),
                  ],
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  categoryTag(
      {required Color color, required IconData icon, required String name}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("Quotes_Description_Page");
      },
      child: SizedBox(
        height: 70,
        width: 85,
        child: Column(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 0.1),
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 3),
            SizedBox(
              width: 85,
              child: Text(
                name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  mostPopular({required double width, required String name, required int i}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed("Quotes_Description_Page");
            setState(() {
              api = ApiHelper.apiHelper.fetchRendomQuotes();
            });
          },
          child: Container(
            height: 110,
            width: width * 0.45,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 0.5,
                ),
              ],
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(Globle.imagesRendom[i]["image"]),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: GoogleFonts.openSans(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  drawerItems(
      {required String name, required Color color, required Icon icon}) {
    return InkWell(
      onTap: () {
        if (name == "By Topic") {
          Navigator.of(context).pushNamed("Category_Page");
        } else if (name == "By Auther") {
          Navigator.of(context).pushNamed("Authors_Page");
        } else if (name == "Favourites") {
          Navigator.of(context).pushNamed("Favorite_Page");
        }
      },
      child: Row(
        children: [
          IconButton(
            icon: icon,
            color: color,
            onPressed: () {},
          ),
          const SizedBox(width: 5),
          Text(
            name,
            style: GoogleFonts.openSans(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  authorsQuotes(
      {required double width, required Color color, required String name}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("Quotes_Description_Page");
        setState(() {
          api = ApiHelper.apiHelper.fetchRendomQuotes();
        });
      },
      child: Container(
        height: 190,
        width: width * 0.45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 0.5,
            ),
          ],
        ),
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}