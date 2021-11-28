class MovieAPIResponseModel {
  MovieAPIResponseModel({
    required this.search,
    required this.totalResults,
    required this.response,
  });

  late final List<Search> search;
  late final String totalResults;
  late final String response;

  MovieAPIResponseModel.fromJson(Map<String, dynamic> json) {
    search = List.from(json['Search']).map((e) => Search.fromJson(e)).toList();
    totalResults = json['totalResults'];
    response = json['Response'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Search'] = search.map((e) => e.toJson()).toList();
    _data['totalResults'] = totalResults;
    _data['Response'] = response;
    return _data;
  }
}

class Search {
  Search({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.type,
    required this.poster,
  });

  late final String title;
  late final String year;
  late final String imdbID;
  late final String type;
  late final String poster;

  Search.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    year = json['Year'];
    imdbID = json['imdbID'];
    type = json['Type'];
    poster = json['Poster'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Title'] = title;
    _data['Year'] = year;
    _data['imdbID'] = imdbID;
    _data['Type'] = type;
    _data['Poster'] = poster;
    return _data;
  }
}
