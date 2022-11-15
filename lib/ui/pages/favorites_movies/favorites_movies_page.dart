import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:movieapp_flutter/core/services/navigation/navigation_service.dart';
import 'package:movieapp_flutter/locator.dart';
import 'package:movieapp_flutter/ui/router.gr.dart';

import '../../../business_logic/bloc/movie_list_bloc/movies_list_bloc.dart';
import '../../widgets/pages_widgets/movie_card.dart';
import '../../widgets/stateless/indicators/loading_circular_progress_indicator.dart';
import '../../widgets/stateless/indicators/no_internet_connection.dart';

class FavoritesMoviesView extends StatefulWidget {
  FavoritesMoviesView();

  @override
  _FavoritesMoviesViewState createState() => _FavoritesMoviesViewState();
}

class _FavoritesMoviesViewState extends State<FavoritesMoviesView> {
  @override
  void didUpdateWidget(FavoritesMoviesView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  final MoviesListBloc _newsBloc = MoviesListBloc();

  @override
  void initState() {
    _newsBloc.add(GetFavoritesMovies());

    super.initState();
  }

  @override
  void dispose() {
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
              if (state is FavoritesMoviesInitial) {
                return LoadingCircularProgressIndicator();
              } else if (state is FavoritesMoviesLoading) {
                return LoadingCircularProgressIndicator();
              } else if (state is FavoritesMoviesLoaded) {
                return _body(context, state.favorites_movies_list);
              } else if (state is FavoritesMoviesError) {
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

  Widget _body(BuildContext context, List movies_list) {
    return GridView.builder(
      controller: ScrollController(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.6, crossAxisCount: 3),
      itemCount: movies_list.length,
      itemBuilder: (context, index) {
        return MovieCard(movies_list[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: Center(
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
              ),
              Container(
                  alignment: AlignmentDirectional.topEnd,
                  child: InkWell(
                    onTap: () {
                      locator<NavigationService>()
                          .pushNamed(SearchPageViewRoute(), context);
                    },
                    child: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )),
            ],
          ),
        ),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return _build();
          } else {
            return NoInternetConnection();
          }
        },
        child: LoadingCircularProgressIndicator(),
      ),
    );
  }
}
