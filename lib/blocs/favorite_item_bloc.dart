
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ponyvie/models/item_model.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteItemBloc extends BlocBase{

  final BehaviorSubject<bool> _isFavoriteController = BehaviorSubject<bool>();
  Observable<bool> get isFavoriteFlux => _isFavoriteController.stream;
  Sink<bool> get isFavoriteEvent => _isFavoriteController.sink;

   final BehaviorSubject<List<MovieModel>> _favoritesController = BehaviorSubject<List<MovieModel>>();
  Sink<List<MovieModel>> get favoritesEvent => _favoritesController.sink;
  
  @override
  void dispose() {
    _favoritesController.close();
    _isFavoriteController.close();
    super.dispose();
  }

}