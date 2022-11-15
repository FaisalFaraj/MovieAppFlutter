part of 'actors_list_bloc.dart';

abstract class ActorsListState extends Equatable {
  const ActorsListState();

  @override
  List<Object?> get props => [];
}

class ActorsListInitial extends ActorsListState {}

class ActorsListLoading extends ActorsListState {}

class ActorsListLoaded extends ActorsListState {
  final List<Actor> actors_list;
  const ActorsListLoaded(this.actors_list);
}

class ActorsListError extends ActorsListState {
  final String? message;
  const ActorsListError(this.message);
}
