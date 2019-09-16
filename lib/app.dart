import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:ponyvie/ui/popular_movies_list.dart';

import 'screens/popular_movies_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pages;
  int index = 0;

  @override
  void initState() {
    pages = [PopularMoviesScreen(), Container(color: Colors.black12,), Container()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ponyvie"),
        actions: <Widget>[
          IconButton(
            icon: new Image.asset(
              'assets/ponylogo.jpg',
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: pages[index],
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: Theme.of(context).primaryColor,
        activeIconColor: Theme.of(context).accentColor,
        tabs: [
          TabData(iconData: Icons.home, title: "Home"),
          TabData(iconData: Icons.filter_list, title: "Genres"),
          TabData(iconData: Icons.star, title: "Favorites")
        ],
        onTabChangedListener: (position) {
          setState(() {
            index = position;
          });
        },
      ),
    );
  }
}


      // bottomNavigationBar: FancyBottomNavigation(
      //   circleColor: Theme.of(context).primaryColor,
      //   activeIconColor: Theme.of(context).accentColor,
      //   tabs: [
      //     TabData(iconData: Icons.home, title: "Home"),
      //     TabData(iconData: Icons.filter_list, title: "Genres"),
      //     TabData(iconData: Icons.star, title: "Favorites")
      //   ],
      //   onTabChangedListener: (position) {
      //     setState(() {
      //       index = position;
      //     });
      //   },
      // ),
