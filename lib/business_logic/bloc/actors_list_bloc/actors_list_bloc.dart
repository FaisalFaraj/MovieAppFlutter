import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/models/actor/actor.dart';
import '../../../core/repositories/actors_repository/actors_repository.dart';
import '../../../locator.dart';

part 'actors_list_event.dart';
part 'actors_list_state.dart';

class ActorsListBloc extends Bloc<ActorsListEvent, ActorsListState> {
  ActorsListBloc() : super(ActorsListInitial()) {
    on<GetActorsList>((event, emit) async {
      try {
        emit(ActorsListLoading());
        final mList = (await locator<ActorsRepository>()
            .fetchActorsList({'paginate': '30'}));
        emit(ActorsListLoaded(mList));
        //   if (mList.error != null) {
        //     emit(ActorsListError(mList.error));
        //   }
        // } on NetworkError {
        //   emit(ActorsListError("Failed to fetch data. is your device online?"));
        // }
      } catch (e) {
        print(e);
      }
    });
  }
}
