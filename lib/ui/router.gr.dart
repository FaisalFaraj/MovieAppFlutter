// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;

import '../core/models/movie/movie.dart' as _i13;
import 'pages/actors/actors_page.dart' as _i6;
import 'pages/comments/comments_page.dart' as _i9;
import 'pages/favorites_movies/favorites_movies_page.dart' as _i10;
import 'pages/home/home_page.dart' as _i4;
import 'pages/main/main_page.dart' as _i1;
import 'pages/movie/movie_page.dart' as _i7;
import 'pages/onboarding/onboarding_page.dart' as _i2;
import 'pages/search/search_page.dart' as _i5;
import 'pages/settings/settings_page.dart' as _i8;
import 'pages/startup/start_up_page.dart' as _i3;

class AppRouter extends _i11.RootStackRouter {
  AppRouter([_i12.GlobalKey<_i12.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    MainPageViewRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.MainPageView(),
      );
    },
    OnboardingPageViewRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.OnboardingPageView(),
      );
    },
    StartUpViewRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.StartUpView(),
      );
    },
    HomePageViewRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.HomePageView(),
      );
    },
    SearchPageViewRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.SearchPageView(),
      );
    },
    ActorsListViewRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.ActorsListView(),
      );
    },
    MoviePageViewRoute.name: (routeData) {
      final args = routeData.argsAs<MoviePageViewRouteArgs>();
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.MoviePageView(args.movie),
      );
    },
    SettingsViewRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.SettingsView(),
      );
    },
    CommentsScreenViewRoute.name: (routeData) {
      final args = routeData.argsAs<CommentsScreenViewRouteArgs>();
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.CommentsScreenView(
          args.movieid,
          args.movie,
        ),
      );
    },
    FavoritesMoviesViewRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.FavoritesMoviesView(),
      );
    },
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(
          MainPageViewRoute.name,
          path: '/main-page-view',
        ),
        _i11.RouteConfig(
          OnboardingPageViewRoute.name,
          path: '/onboarding-page-view',
        ),
        _i11.RouteConfig(
          StartUpViewRoute.name,
          path: '/',
        ),
        _i11.RouteConfig(
          HomePageViewRoute.name,
          path: '/home-page-view',
        ),
        _i11.RouteConfig(
          SearchPageViewRoute.name,
          path: '/search-page-view',
        ),
        _i11.RouteConfig(
          ActorsListViewRoute.name,
          path: '/actors-list-view',
        ),
        _i11.RouteConfig(
          MoviePageViewRoute.name,
          path: '/movie-page-view',
        ),
        _i11.RouteConfig(
          SettingsViewRoute.name,
          path: '/settings-view',
        ),
        _i11.RouteConfig(
          CommentsScreenViewRoute.name,
          path: '/comments-screen-view',
        ),
        _i11.RouteConfig(
          MoviePageViewRoute.name,
          path: '/movie-page-view',
        ),
        _i11.RouteConfig(
          FavoritesMoviesViewRoute.name,
          path: '/favorites-movies-view',
        ),
      ];
}

/// generated route for
/// [_i1.MainPageView]
class MainPageViewRoute extends _i11.PageRouteInfo<void> {
  const MainPageViewRoute()
      : super(
          MainPageViewRoute.name,
          path: '/main-page-view',
        );

  static const String name = 'MainPageViewRoute';
}

/// generated route for
/// [_i2.OnboardingPageView]
class OnboardingPageViewRoute extends _i11.PageRouteInfo<void> {
  const OnboardingPageViewRoute()
      : super(
          OnboardingPageViewRoute.name,
          path: '/onboarding-page-view',
        );

  static const String name = 'OnboardingPageViewRoute';
}

/// generated route for
/// [_i3.StartUpView]
class StartUpViewRoute extends _i11.PageRouteInfo<void> {
  const StartUpViewRoute()
      : super(
          StartUpViewRoute.name,
          path: '/',
        );

  static const String name = 'StartUpViewRoute';
}

/// generated route for
/// [_i4.HomePageView]
class HomePageViewRoute extends _i11.PageRouteInfo<void> {
  const HomePageViewRoute()
      : super(
          HomePageViewRoute.name,
          path: '/home-page-view',
        );

  static const String name = 'HomePageViewRoute';
}

/// generated route for
/// [_i5.SearchPageView]
class SearchPageViewRoute extends _i11.PageRouteInfo<void> {
  const SearchPageViewRoute()
      : super(
          SearchPageViewRoute.name,
          path: '/search-page-view',
        );

  static const String name = 'SearchPageViewRoute';
}

/// generated route for
/// [_i6.ActorsListView]
class ActorsListViewRoute extends _i11.PageRouteInfo<void> {
  const ActorsListViewRoute()
      : super(
          ActorsListViewRoute.name,
          path: '/actors-list-view',
        );

  static const String name = 'ActorsListViewRoute';
}

/// generated route for
/// [_i7.MoviePageView]
class MoviePageViewRoute extends _i11.PageRouteInfo<MoviePageViewRouteArgs> {
  MoviePageViewRoute({required _i13.Movie movie})
      : super(
          MoviePageViewRoute.name,
          path: '/movie-page-view',
          args: MoviePageViewRouteArgs(movie: movie),
        );

  static const String name = 'MoviePageViewRoute';
}

class MoviePageViewRouteArgs {
  const MoviePageViewRouteArgs({required this.movie});

  final _i13.Movie movie;

  @override
  String toString() {
    return 'MoviePageViewRouteArgs{movie: $movie}';
  }
}

/// generated route for
/// [_i8.SettingsView]
class SettingsViewRoute extends _i11.PageRouteInfo<void> {
  const SettingsViewRoute()
      : super(
          SettingsViewRoute.name,
          path: '/settings-view',
        );

  static const String name = 'SettingsViewRoute';
}

/// generated route for
/// [_i9.CommentsScreenView]
class CommentsScreenViewRoute
    extends _i11.PageRouteInfo<CommentsScreenViewRouteArgs> {
  CommentsScreenViewRoute({
    required String? movieid,
    required _i13.Movie movie,
  }) : super(
          CommentsScreenViewRoute.name,
          path: '/comments-screen-view',
          args: CommentsScreenViewRouteArgs(
            movieid: movieid,
            movie: movie,
          ),
        );

  static const String name = 'CommentsScreenViewRoute';
}

class CommentsScreenViewRouteArgs {
  const CommentsScreenViewRouteArgs({
    required this.movieid,
    required this.movie,
  });

  final String? movieid;

  final _i13.Movie movie;

  @override
  String toString() {
    return 'CommentsScreenViewRouteArgs{movieid: $movieid, movie: $movie}';
  }
}

/// generated route for
/// [_i10.FavoritesMoviesView]
class FavoritesMoviesViewRoute extends _i11.PageRouteInfo<void> {
  const FavoritesMoviesViewRoute()
      : super(
          FavoritesMoviesViewRoute.name,
          path: '/favorites-movies-view',
        );

  static const String name = 'FavoritesMoviesViewRoute';
}
