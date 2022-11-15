import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:sizer/sizer.dart';

import '../../../business_logic/bloc/movie_list_bloc/movies_list_bloc.dart';
import '../../../core/models/genre/genre.dart';
import '../../../core/models/movie/movie.dart';
import '../../widgets/pages_widgets/section_image_slider.dart';
import '../../widgets/pages_widgets/trending_image_slider.dart';
import '../../widgets/stateless/indicators/loading_circular_progress_indicator.dart';
// import 'package:logging/logging.dart';
import '../../widgets/stateless/indicators/no_internet_connection.dart';

//TODO treand method
//TODO history system
//TODO movies rates imdb,rotten tomatos
class HomePageView extends StatefulWidget {
  HomePageView();

  @override
  _MoviesListViewState createState() => _MoviesListViewState();
}

class _MoviesListViewState extends State<HomePageView> {
  @override
  void didUpdateWidget(HomePageView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  // final _log = Logger('HomePageView');

  final MoviesListBloc _newsBloc = MoviesListBloc();

  @override
  void initState() {
    _newsBloc.add(GetMoviesList());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildListmovies() {
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
              if (state is MoviesListInitial) {
                return LoadingCircularProgressIndicator();
              } else if (state is MoviesListLoading) {
                return LoadingCircularProgressIndicator();
              } else if (state is MoviesListLoaded) {
                return _body(context, state.movies_list, state.genres_list);
              } else if (state is MoviesListError) {
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

  Widget _body(
      BuildContext context, List<Movie> movies_list, List<Genre> genres_list) {
    var trend_movies_list = movies_list.take(20).toList()..shuffle();

    return RefreshIndicator(
      color: Theme.of(context).colorScheme.onPrimary,
      onRefresh: () async {
        setState(() {});
      },
      child: SingleChildScrollView(
        child: Wrap(
          children: [
            Container(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 30, top: 10, bottom: 10),
                child: Text(
                  AppLocalizations.of(context)!.trending,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 30.0),
              child: TreImageSlider(trend_movies_list),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 30.0),
              child: Column(
                  children: genres_list.map((e) {
                return Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 10.0),
                  child: SecImageSlider(
                      e.name!, get_section_list(e.name!, movies_list)),
                );
              }).toList()),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return _buildListmovies();
          } else {
            return NoInternetConnection();
          }
        },
        child: LoadingCircularProgressIndicator(),
      ),
    );
  }

  List<Movie> get_section_list(String section_name, List<Movie> movies_list) {
    var section_list = <Movie>[];
    for (var movie in movies_list) {
      for (var genre in movie.genres!) {
        if (genre['name'] == section_name) {
          section_list.add(movie);
        }
      }
    }
    return section_list;
  }
}
