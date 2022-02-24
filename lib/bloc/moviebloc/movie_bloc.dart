import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app_tmdb/bloc/moviebloc/movie_bloc_event.dart';
import 'package:flutter_movie_app_tmdb/bloc/moviebloc/movie_bloc_state.dart';
import 'package:flutter_movie_app_tmdb/src/model/movie.dart';
import 'package:flutter_movie_app_tmdb/src/service/api_service.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieLoading());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieEventStarted) {
      yield* _mapMovieEventStateToState(event.movieId, event.query);
    }
  }

  Stream<MovieState> _mapMovieEventStateToState(
      int movieId, String query) async* {
    final service = ApiService();
    yield MovieLoading();
    try{
      late List<Movie> movieList;
      if(movieId == 0){
        movieList = await service.getTopRatedMovie();
      }

      yield MovieLoaded(movieList);
    } on Exception catch (e) {
      print(e);
      yield MovieError();
    }
  }
}