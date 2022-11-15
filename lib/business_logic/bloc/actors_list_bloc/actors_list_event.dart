part of 'actors_list_bloc.dart';

abstract class ActorsListEvent extends Equatable {
  const ActorsListEvent();

  @override
  List<Object> get props => [];
}

class GetActorsList extends ActorsListEvent {}
