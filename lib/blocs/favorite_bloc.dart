import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ponyvie/models/item_model.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteBloc extends BlocBase {
  static FavoriteBloc _instance = FavoriteBloc._internal();

  factory FavoriteBloc.getInstance() {
    if (_instance == null) _instance = FavoriteBloc._internal();
    return _instance;
  }

  FavoriteBloc._internal() {
    final list = Observable.just(<MovieModel>[]).publishValue().autoConnect();

    final addItem = _add.withLatestFrom(
        list, (item, List<MovieModel> list) => list..add(item))
      ..listen(_items.add);

    final removeItem = _remove.withLatestFrom(
        list, (item, List<MovieModel> list) => list..remove(item))
      ..listen(_items.add);
  }

  final _add = BehaviorSubject<MovieModel>();
  final _remove = BehaviorSubject<MovieModel>();
  final _items = BehaviorSubject<List<MovieModel>>();

  Observable<List<MovieModel>> get items => _items;
  Observable<int> total;

  void add(MovieModel i) => _add.add(i);
  void remove(MovieModel i) => _remove.add(i);

  @override
  void dispose() {
    _items.close();
    _add.close();
    _remove.close();
    _instance = null;
    super.dispose();
  }
}
