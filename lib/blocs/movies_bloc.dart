import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ponyvie/models/item_model.dart';
import 'package:ponyvie/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc extends BlocBase{
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<ItemModel>();
  Observable<ItemModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async{
    ItemModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  @override
  dispose() {
    _moviesFetcher?.close();
    super.dispose();
  }
}
