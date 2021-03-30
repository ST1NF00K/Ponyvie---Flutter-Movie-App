import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ponyvie/models/popular_movies_model.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';

class PopularMoviesBloc extends BlocBase{
  final _repository = Repository();
  final _popularMoviesFetcher = PublishSubject<PopularMoviesModel>();

  Observable<PopularMoviesModel> get allPopularMovies => _popularMoviesFetcher.stream;

  fetchAllPopularMovies() async{
    PopularMoviesModel popularMoviesModel = await _repository.fetchAllPopularMovies();
    _popularMoviesFetcher.sink.add(popularMoviesModel);
  }

  @override
  dispose() {
    _popularMoviesFetcher?.close();
    super.dispose();
  }
}