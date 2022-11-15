import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movieapp_flutter/core/services/navigation/navigation_service.dart';
import '../../../core/services/hive/hive_service.dart';
import '../../../locator.dart';
import 'package:rate/rate.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_api/youtube_api.dart';

import '../../../business_logic/bloc/movie_list_bloc/movies_list_bloc.dart';
import '../../../core/models/movie/movie.dart';
import '../../widgets/pages_widgets/actors_image_slide.dart';
import '../../widgets/pages_widgets/section_image_slider.dart';
import '../../widgets/stateless/indicators/loading_circular_progress_indicator.dart';
import 'package:movieapp_flutter/ui/router.gr.dart';

// ignore: must_be_immutable
class MoviePageView extends StatefulWidget {
  Movie movie;

  MoviePageView(this.movie);

  @override
  _MovieViewState createState() => _MovieViewState();
}

class _MovieViewState extends State<MoviePageView> {
  @override
  void didUpdateWidget(MoviePageView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  TextEditingController? commentController;
  FocusNode? commentFocusNode;
  bool is_favorite = false;

  var favorites_box = locator<HiveService>().favorites_box!;

  YoutubeAPI ytApi = YoutubeAPI('AIzaSyBY1zZmZr96jWo8AEOE-AMp_pZR78rBkwE');
  List<YouTubeVideo> videoResult = [];

  final MoviesListBloc _newsBloc = MoviesListBloc();

  @override
  void initState() {
    _newsBloc.add(GetMovie(widget.movie.id!));

    super.initState();

    commentController = TextEditingController();

    commentFocusNode = FocusNode();
  }

  @override
  void dispose() {
    commentController!.dispose();

    super.dispose();
  }

  Widget _build() {
    return Container(
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<MoviesListBloc, MoviesListState>(
          listener: (context, state) {
            if (state is MoviesListError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<MoviesListBloc, MoviesListState>(
            builder: (context, state) {
              if (state is MovieInitial) {
                return LoadingCircularProgressIndicator();
              } else if (state is MovieLoading) {
                return LoadingCircularProgressIndicator();
              } else if (state is MovieLoaded) {
                return _body(context, state.movie, state.movies_list);
              } else if (state is MovieError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, Movie movie, List<Movie> movies_list) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Theme.of(context).colorScheme.primary,
          child: CachedNetworkImage(
            alignment: Alignment.center,
            fit: BoxFit.cover,
            imageUrl: movie.img!,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            errorWidget: (context, url, error) =>
                Center(child: Icon(Icons.error)),
          ),
        ),
        aboutMovieWidget(context, movie, movies_list),
        Container(
          alignment: AlignmentDirectional.topEnd,
          margin: EdgeInsetsDirectional.only(top: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FavoriteButton(
                iconSize: 55,
                iconDisabledColor: Colors.white,
                isFavorite: is_favorite,
                valueChanged: (_isFavorite) {
                  setState(() {
                    if (_isFavorite) {
                      favorites_box.put(movie.id.toString(), _isFavorite);

                      return;
                    } else {
                      favorites_box.delete(movie.id.toString());

                      return;
                    }
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  locator<NavigationService>().pushNamed(
                      CommentsScreenViewRoute(movieid: movie.id, movie: movie),
                      context);
                },
                child: Icon(
                  Icons.people_alt_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget aboutMovieWidget(
      BuildContext context, Movie movie, List<Movie> movies_list) {
    var _genres = '';

    for (var genre in movie.genres!) {
      String name = genre['name'];
      _genres = _genres + name.replaceFirst(name[0], name[0].toUpperCase());
      ;
      if (movie.genres!.last != genre) {
        _genres = _genres + ',';
      }
    }

    return SlidingUpPanel(
      backdropEnabled: true,
      maxHeight: 73.h,
      minHeight: 35.h,
      //  maxHeight: 580.0,
      // minHeight: 340.0,
      parallaxEnabled: true,
      parallaxOffset: .1,
      panel: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: 73.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(60)),
                  ),
                  child: Center(
                      child: Container(
                    padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
                    child: Column(children: [
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          _genres,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 12.sp,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          movie.title!,
                          maxLines: 2,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Rate(
                            iconSize: 12.sp,
                            color: Theme.of(context).colorScheme.secondary,
                            allowHalf: true,
                            allowClear: true,
                            initialValue: movie.avg_rate != null
                                ? movie.avg_rate!.toDouble()
                                : Random().nextInt(5).toDouble(),
                            readOnly: true,
                            onChange: (rating) {},
                          )),
                          Spacer(),
                          Container(
                            child: Text(
                              movie.running_time!.hours.toString() +
                                  'h ' +
                                  movie.running_time!.minutes.toString() +
                                  'm ',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 12.sp,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        height: 12.h,
                        child: Text(
                          movie.description!,
                          maxLines: 5,
                          style: TextStyle(
                              height: 1.2,
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 11.sp,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          AppLocalizations.of(context)!.cast,
                          maxLines: 2,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      ActorsImageSlider(movie.cast!),
                      SizedBox(
                        height: 1.h,
                      ),
                      SecImageSlider(
                          AppLocalizations.of(context)!.similar, movies_list),
                    ]),
                  ))),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: InkWell(
              onTap: () {
                Future<String?> get_video_url_play() async {
                  var query = movie.title! + ' trailer';
                  videoResult = await ytApi.search(
                    query,
                    type: 'video',
                  );

                  var _url = Uri.parse(videoResult[0].url);

                  await launchUrl(_url, mode: LaunchMode.externalApplication);
                  ;

                  return videoResult[0].url;
                }

                get_video_url_play();
              },
              child: Icon(
                Icons.play_circle_fill_outlined,
                color: Colors.blue[300],
                size: 55,
              ),
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 12,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(60), right: Radius.circular(60)),
                ),
              ))
        ],
      ),
      borderRadius: BorderRadius.vertical(top: Radius.circular(60)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (favorites_box.get(widget.movie.id.toString()) == true) {
      is_favorite = true;
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: _build(),
    );
  }
}
