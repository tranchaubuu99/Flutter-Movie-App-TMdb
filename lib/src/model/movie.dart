class Movie {
  String? backdropPath;
  int? id;
  String? overview;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;

  Movie(
      {this.backdropPath,
        this.id,
        this.overview,
        this.posterPath,
        this.releaseDate,
        this.title,
        this.video});

  factory Movie.fromJson(dynamic json) {
    if (json == null) {
      return Movie();
    }

    return Movie(
        backdropPath: json['backdrop_path'],
        id: json['id'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        title: json['title'],
        video: json['video']);
  }
}