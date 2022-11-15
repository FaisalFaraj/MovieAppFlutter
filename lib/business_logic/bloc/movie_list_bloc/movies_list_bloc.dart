import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/services/hive/hive_service.dart';

import '../../../core/models/genre/genre.dart';
import '../../../core/models/movie/movie.dart';
import '../../../core/repositories/movies_repository/movies_repository.dart';
import '../../../locator.dart';

part 'movies_list_event.dart';
part 'movies_list_state.dart';

class MoviesListBloc extends Bloc<MoviesListEvent, MoviesListState> {
  MoviesListBloc() : super(MoviesListInitial()) {
    on<GetMoviesList>((event, emit) async {
      try {
        emit(MoviesListLoading());

        final movies_list = await locator<MoviesRepository>().fetchMoviesList({
          'paginate': '50',
          'lang': locator<HiveService>().settings_box!.get('locale')
        });

        final genres_list = await locator<MoviesRepository>().fetchGenresList(
            {'lang': locator<HiveService>().settings_box!.get('locale')});

        emit(MoviesListLoaded(movies_list, genres_list));
        //   if (mList.error != null) {
        //     emit(MoviesListError(mList.error));
        //   }
        // } on NetworkError {
        //   emit(MoviesListError("Failed to fetch data. is your device online?"));
        // }
      } catch (e) {
        print(e);
      }
    });

    on<GetFavoritesMovies>((event, emit) async {
      try {
        emit(FavoritesMoviesLoading());
        var favorites_box = locator<HiveService>().favorites_box!;
        var favorites_movies_list = <Movie>[];
        for (var key in favorites_box.keys) {
          var movie = await locator<MoviesRepository>().fetchMovie({
            'id': key,
            'lang': locator<HiveService>().settings_box!.get('locale')
          });

          favorites_movies_list.add(movie);
        }

        emit(FavoritesMoviesLoaded(favorites_movies_list));
        //   if (mList.error != null) {
        //     emit(MoviesListError(mList.error));
        //   }
        // } on NetworkError {
        //   emit(MoviesListError("Failed to fetch data. is your device online?"));
        // }
      } catch (e) {
        print(e);
      }
    });
    on<GetMovie>((event, emit) async {
      try {
        emit(MovieLoading());

        var movie = await locator<MoviesRepository>().fetchMovie({
          'id': event.movie_id.toString(),
          'lang': locator<HiveService>().settings_box!.get('locale'),
        });

        final movies_list = await locator<MoviesRepository>().fetchMoviesList({
          'paginate': '30',
          'lang': locator<HiveService>().settings_box!.get('locale')
        });
        emit(MovieLoaded(movie, movies_list));
        //   if (mList.error != null) {
        //     emit(MoviesListError(mList.error));
        //   }
        // } on NetworkError {
        //   emit(MoviesListError("Failed to fetch data. is your device online?"));
        // }
      } catch (e) {
        print(e);
      }
    });
  }
}
