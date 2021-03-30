class ApiResponse {
  int _page;
  int _totalResults;
  int _totalPages;
  List<MovieModel> _results = [];

  ApiResponse.fromJSON(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
    _page = parsedJson['page'];
    _totalPages = parsedJson['total_pages'];
    _totalResults = parsedJson['total_results'];
    List<MovieModel> temp = [];

    for (int i = 0; i < parsedJson['results'].length; i++) {
      MovieModel result = MovieModel(parsedJson['results'][i]);
      temp.add(result);
    }

    _results = temp;
  }

  List<MovieModel> get results => _results;

  int get totalPages => _totalPages;

  int get totalResults => _totalResults;

  int get page => _page;
}

class MovieModel {
  int _voteCount;
  int _id;
  bool _video;
  var _voteAverage;
  String _title;
  double _popularity;
  String _posterPath;
  String _originalLanguage;
  String _originalTitle;
  List<int> _genreIds = [];
  String _backdropPath;
  bool _adult;
  String _overview;
  String _releaseDate;

  MovieModel(result) {
    _voteCount = result['vote_count'];
    _id = result['id'];
    _video = result['video'];
    _voteAverage = result['vote_average'];
    _title = result['title'];
    _popularity = result['popularity'];
    _posterPath = result['poster_path'];
    _originalLanguage = result['original_language'];
    _originalTitle = result['original_title'];

    for (int i = 0; i < result['genre_ids'].length; i++) {
      _genreIds.add(result['genre_ids'][i]);
    }

    _backdropPath = result['backdrop_path'];
    _adult = result['adult'];
    _overview = result['overview'];
    _releaseDate = result['release_date'];
  }

  String get releasDate => _releaseDate;

  String get overview => _overview;

  bool get adult => _adult;

  String get backdropPath => _backdropPath;

  List<int> get genreIds => _genreIds;

  String get originalTitle => _originalTitle;

  String get originalLanguage => _originalLanguage;

  String get posterPath => _posterPath;

  double get popularity => _popularity;

  String get title => _title;

  double get voteAverage => _voteAverage.toDouble();

  bool get video => _video;

  int get id => _id;

  int get voteCount => _voteCount;


  bool operator ==(other) => other.id == id;

  int get hashCode =>
      super.hashCode ^ id.hashCode ^ video.hashCode ^ posterPath.hashCode;
}
