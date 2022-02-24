class MovieDetail {
  String? id;
  String? title;
  String? backdropPath;
  String? homePage;
  String? originalTitle;
  String? overview;
  String? releaseDate;

  String? trailerId;

  MovieDetail(
      {this.id,
        this.title,
        this.backdropPath,
        this.homePage,
        this.originalTitle,
        this.overview,
        this.releaseDate,
        this.trailerId});

  factory MovieDetail.fromJson(dynamic json) {
    if (json == null) {
      return MovieDetail();
    }

    return MovieDetail(
        id: json['id'].toString(),
        title: json['title'],
        backdropPath: json['backdrop_path'],
        homePage: json['home_page'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        releaseDate: json['release_date'],
        trailerId: json['trailerId']);
  }
}