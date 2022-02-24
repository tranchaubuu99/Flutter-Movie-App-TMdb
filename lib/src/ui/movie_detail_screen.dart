import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_app_tmdb/bloc/moviedetailbloc/movie_detail_bloc.dart';
import 'package:flutter_movie_app_tmdb/bloc/moviedetailbloc/movie_detail_event.dart';
import 'package:flutter_movie_app_tmdb/bloc/moviedetailbloc/movie_detail_state.dart';
import 'package:flutter_movie_app_tmdb/src/model/movie.dart';
import 'package:flutter_movie_app_tmdb/src/model/movie_detail.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  MovieDetailScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
      return BlocProvider(
        create: (_) => MovieDetailBloc()..add(MovieDetailEventStated(movie.id!)),
        child: WillPopScope(
          child: Scaffold(
            body: _buildDetailBody(context),
          ),
          onWillPop: () async => true,
        ),
      );
  }

  Widget _buildDetailBody(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        if (state is MovieDetailLoading) {
          return Center(
            child: Platform.isAndroid
                ? CircularProgressIndicator()
                : CupertinoActivityIndicator(),
          );
        } else if (state is MovieDetailLoaded) {
          MovieDetail movieDetail = state.detail;
          return Stack(
            children: <Widget>[
              ClipPath(
                child: ClipRect(
                  child: CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/original/${movieDetail.backdropPath}',
                    height: MediaQuery.of(context).size.height/2,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Platform.isAndroid
                        ? CircularProgressIndicator()
                        : CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) =>
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/img_not_found.jpg'),
                            ),
                          ),
                        ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 120),
                    child: GestureDetector(
                      onTap: () async {
                        final youtubeUrl = 'https://www.youtube.com/embed/${movieDetail.trailerId}';
                        print(youtubeUrl);
                        if (await canLaunch(youtubeUrl)) {
                          await launch(youtubeUrl);
                        }
                      },
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.play_circle_outlined,
                                color: Colors.red,
                                size: 65),
                            Text(
                              movieDetail.title!.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'muli',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    )
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Overview'.toUpperCase(),
                              style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 35,
                          child: Text(
                            movieDetail.overview!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Release Date'.toUpperCase(),
                                style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold),),
                                Text(
                                  movieDetail.releaseDate!,
                                  style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.yellow[800], fontSize: 12),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}