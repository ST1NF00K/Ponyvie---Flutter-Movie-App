import 'package:flutter/material.dart';
import 'package:ponyvie/blocs/favorite_bloc.dart';
import 'package:ponyvie/models/item_model.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  FavoriteBloc favoriteBloc;

  @override
  void initState() { 
    favoriteBloc = FavoriteBloc.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MovieModel>>(
      stream: favoriteBloc.items,
      initialData: [],
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index){
            return ListTile(title: Text("${snapshot.data[index].title}"),
            subtitle: Text("${snapshot.data[index].overview}"), leading: Icon(Icons.star),);  
          },
        );
      }
    );
  }
}