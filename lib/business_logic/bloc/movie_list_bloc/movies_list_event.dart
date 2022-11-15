part of 'movies_list_bloc.dart';

abstract class MoviesListEvent extends Equatable {
  const MoviesListEvent();

  @override
  List<Object> get props => [];
}

class GetMoviesList extends MoviesListEvent {}

class GetFavoritesMovies extends MoviesListEvent {}

class GetMovie extends MoviesListEvent {
  final String movie_id;

  GetMovie(this.movie_id);
}
