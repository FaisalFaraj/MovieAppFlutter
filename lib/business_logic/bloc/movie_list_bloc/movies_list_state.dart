part of 'movies_list_bloc.dart';

abstract class MoviesListState extends Equatable {
  const MoviesListState();

  @override
  List<Object?> get props => [];
}

class MoviesListInitial extends MoviesListState {}

class MoviesListLoading extends MoviesListState {}

class MoviesListLoaded extends MoviesListState {
  final List<Movie> movies_list;
  final List<Genre> genres_list;

  const MoviesListLoaded(this.movies_list, this.genres_list);
}

class MoviesListError extends MoviesListState {
  final String? message;
  const MoviesListError(this.message);
}

class FavoritesMoviesInitial extends MoviesListState {}

class FavoritesMoviesLoading extends MoviesListState {}

class FavoritesMoviesLoaded extends MoviesListState {
  final List<Movie> favorites_movies_list;

  const FavoritesMoviesLoaded(this.favorites_movies_list);
}

class FavoritesMoviesError extends MoviesListState {
  final String? message;
  const FavoritesMoviesError(this.message);
}

class MovieInitial extends MoviesListState {}

class MovieLoading extends MoviesListState {}

class MovieLoaded extends MoviesListState {
  final Movie movie;
  final List<Movie> movies_list;
  const MovieLoaded(this.movie, this.movies_list);
}

class MovieError extends MoviesListState {
  final String? message;
  const MovieError(this.message);
}
