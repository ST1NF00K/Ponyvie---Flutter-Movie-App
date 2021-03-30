import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ponyvie/blocs/favorite_bloc.dart';
import 'package:ponyvie/blocs/movie_detail_bloc.dart';
import 'package:ponyvie/models/item_model.dart';
import 'package:ponyvie/models/trailer_model.dart';

import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class MovieDetail extends StatefulWidget {
  final MovieModel movieModel;

  MovieDetail({this.movieModel});

  @override
  State<StatefulWidget> createState() {
    return MovieDetailState();
  }
}

class MovieDetailState extends State<MovieDetail> {
  MovieDetailBloc _movieDetailBloc;
  FavoriteBloc _favoriteBloc;
  StreamSubscription _subscription;

  @override
  void initState() {
    _movieDetailBloc = MovieDetailBloc(widget.movieModel);
    _favoriteBloc = FavoriteBloc.getInstance();
    _subscription =  _favoriteBloc.items.listen(_movieDetailBloc.favoritesEvent);

    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    _movieDetailBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        //opacity: top == 80.0 ? 1.0 : 0.0,
                        opacity: 1.0,
                        child: Text(
                          widget.movieModel.title,
                          maxLines: 2,
                          style: TextStyle(fontSize: 16.0),
                        )),
                    background: Image.network(
                      "https://image.tmdb.org/t/p/w500${widget.movieModel.posterPath}",
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 1.0, right: 1.0),
                    ),
                    Text(
                      "${widget.movieModel.voteAverage}",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    ),
                    Text(
                      widget.movieModel.releasDate,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    ),
                    StreamBuilder(
                        stream: _movieDetailBloc.isFavorite,
                        initialData: false,
                        builder: (context, AsyncSnapshot<bool> snapshot) {
                          return snapshot.hasData && snapshot.data
                              ? IconButton(
                                  icon: Icon(Icons.star),
                                  onPressed: () {
                                    _favoriteBloc.remove(widget.movieModel);
                                  },
                                )
                              : IconButton(
                                  icon: Icon(Icons.star_border),
                                  onPressed: () {
                                    _favoriteBloc.add(widget.movieModel);
                                  },
                                );
                        }),
                  ],
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Text(
                  '',

                  /// widget.movieModel.    description,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                Text(
                  "Trailer",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                StreamBuilder(
                  stream: _movieDetailBloc.movieTrailers,
                  builder: (context, AsyncSnapshot<TrailerModel> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.results.length > 0)
                        return trailerLayout(snapshot.data);
                      else
                        return noTrailer(snapshot.data);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget noTrailer(TrailerModel data) {
    return Center(
      child: Container(
        child: Text("No trailer available"),
      ),
    );
  }

  Widget trailerLayout(TrailerModel data) {
    if (data.results.length > 1) {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
//          trailerItem(data, 1),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
        ],
      );
    }
  }

  trailerItem(TrailerModel data, int index) {
    return Expanded(
      child: InkResponse(
        enableFeedback: true,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.play_circle_filled),
              title: Text(
                data.results[index].name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        onTap: () => _openYoutube(data.results[index].key),
      ),
    );
  }

  _openYoutube(String videoId) async {
    try {
      await launch(
        'https://www.youtube.com/watch?v=$videoId',
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: new CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}
