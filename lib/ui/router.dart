import 'package:auto_route/auto_route.dart';
import 'package:movieapp_flutter/ui/pages/comments/comments_page.dart';
import 'package:movieapp_flutter/ui/pages/favorites_movies/favorites_movies_page.dart';
import 'pages/home/home_page.dart';
import 'pages/main/main_page.dart';
import 'pages/search/search_page.dart';

import 'pages/actors_list/actors_list_page.dart';
import 'pages/movie/movie_page.dart';
import 'pages/onboarding_page/onboarding_page.dart';
import 'pages/settings/settings_page.dart';
import 'pages/startup/start_up_page.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page', routes: <AutoRoute>[
  AutoRoute(page: StartUpView, initial: true),
  AutoRoute(page: MainPageView),
  AutoRoute(page: OnboardingPageView),
  AutoRoute(page: HomePageView),
  AutoRoute(page: SearchPageView),
  AutoRoute(page: ActorsListView),
  AutoRoute(page: MoviePageView),
  AutoRoute(page: SettingsView),
  AutoRoute(page: CommentsScreenView),
  AutoRoute(page: MoviePageView),
  AutoRoute(page: FavoritesMoviesView),
])
class $AppRouter {}
