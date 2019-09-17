import 'package:flutter/material.dart';
import 'package:ponyvie/screens/favorites_screen.dart';
import 'package:ponyvie/screens/popular_movies_screen.dart';

class Item extends StatefulWidget {

  final int index;
  final String title;

  Item({this.index, this.title});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {

  @override
  void initState() {
    super.initState();
  }

 reverse(int index) async {
    Navigator.of(context).pop();
    switch(index){
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PopularMoviesScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Container()),
        );
        break;
         case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FavoritesScreen()),
        );
        break;
      default:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Container()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(bottom: 10.0),
            height: 75.0,
            child: RaisedButton(
              color: Colors.blueGrey,
              child: ListTile(
                leading: Icon(
                  Icons.movie
                ),
                title: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 18.0
                  ),
                ),
                subtitle: Text(
                  'Visit for more information on '+widget.title
                ),
              ),
              onPressed: (){
                reverse(widget.index);
              },
            ),
          );
  }
}