import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:sizer/sizer.dart';

import '../../../business_logic/bloc/actors_list_bloc/actors_list_bloc.dart';
import '../../../core/models/actor/actor.dart';
import '../../widgets/pages_widgets/actor_card.dart';
import '../../widgets/stateless/indicators/loading_circular_progress_indicator.dart';
import '../../widgets/stateless/indicators/no_internet_connection.dart';

class ActorsListView extends StatefulWidget {
  ActorsListView();

  @override
  _ActorsListViewState createState() => _ActorsListViewState();
}

class _ActorsListViewState extends State<ActorsListView> {
  @override
  void didUpdateWidget(ActorsListView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  final ActorsListBloc _newsBloc = ActorsListBloc();

  @override
  void initState() {
    _newsBloc.add(GetActorsList());
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
        child: BlocListener<ActorsListBloc, ActorsListState>(
          listener: (context, state) {
            if (state is ActorsListError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<ActorsListBloc, ActorsListState>(
            builder: (context, state) {
              if (state is ActorsListInitial) {
                return LoadingCircularProgressIndicator();
              } else if (state is ActorsListLoading) {
                return LoadingCircularProgressIndicator();
              } else if (state is ActorsListLoaded) {
                return _body(context, state.actors_list);
              } else if (state is ActorsListError) {
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

  Widget _body(BuildContext context, List<Actor> actors_list) {
    List trend_actors_list = actors_list.take(20).toList()..shuffle();
    return RefreshIndicator(
        color: Theme.of(context).colorScheme.onPrimary,
        onRefresh: () async {
          setState(() {});
        },
        child: ListView(
          padding: EdgeInsets.only(left: 20, right: 20),
          children: [
            Container(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
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
            GridView.builder(
              controller: ScrollController(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2, crossAxisCount: 1),
              itemCount: trend_actors_list.length,
              itemBuilder: (context, index) {
                return ActorCard(trend_actors_list[index]);
              },
            )
          ],
        ));
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
