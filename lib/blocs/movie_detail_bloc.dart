import 'package:ponyvie/models/item_model.dart';
import 'package:rxdart/rxdart.dart';
import '../models/trailer_model.dart';
import '../resources/repository.dart';

class MovieDetailBloc {
  final _repository = Repository();
  final _favorites = BehaviorSubject<List<MovieModel>>();

  Observable<TrailerModel> movieTrailers;

  MovieDetailBloc(MovieModel movie) {
    isFavorite = _favorites.map((e) => e.contains(movie));

    movieTrailers = Observable.fromFuture(_repository.fetchTrailers(movie.id));
  }

  Observable<bool> isFavorite;

  void favoritesEvent(List<MovieModel> i) => _favorites.add(i);

  dispose() async {
    _favorites.close();
  }
}
