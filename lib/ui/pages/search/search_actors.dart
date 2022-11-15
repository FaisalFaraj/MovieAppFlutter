import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/constant/end_point_parameters.dart';
import '../../../core/repositories/actors_repository/actors_repository.dart';
import '../../../locator.dart';
import '../../widgets/pages_widgets/actor_card.dart';
import '../../widgets/stateless/indicators/empty_list_indicator.dart';
import '../../widgets/stateless/indicators/error_indicator.dart';
import '../../widgets/stateless/indicators/no_internet_connection.dart';
import '../../../business_logic/bloc/actors_list_bloc/actors_list_bloc.dart';
import '../../../core/models/actor/actor.dart';
import '../../widgets/stateless/indicators/loading_circular_progress_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchActors extends StatefulWidget {
  SearchActors();

  @override
  _SearchActorsState createState() => _SearchActorsState();
}

class _SearchActorsState extends State<SearchActors> {
  List current_actors = [];

  final ActorsListBloc _newsBloc = ActorsListBloc();

  final TextEditingController _textFieldController = TextEditingController();
  final ScrollController? controller = ScrollController();

  final _pagingController = PagingController<int, Actor>(
    firstPageKey: 1,
  );
  String _search = '';
  @override
  void initState() {
    _newsBloc.add(GetActorsList());
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(SearchActors oldWidget) {
    _pagingController.refresh();
    super.didUpdateWidget(oldWidget);
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
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 10,
          child: TextField(
            maxLines: 1,
            onChanged: (value) {
              _search = value;
              _pagingController.refresh();
            },
            controller: _textFieldController,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontSize: 13.sp),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20), right: Radius.circular(20)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20), right: Radius.circular(20)),
                  borderSide: BorderSide(
                    width: 0,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.primaryContainer,
                suffixIcon: Icon(Icons.search,
                    color: Theme.of(context).colorScheme.onPrimaryContainer)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(child: _pagedListView())
      ],
    );
  }

  Widget _pagedListView() {
    return PagedListView.separated(
      physics: BouncingScrollPhysics(),
      scrollController: controller,
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Actor>(
        itemBuilder: (context, actor, index) {
          return ActorCard(actor);
        },
        firstPageProgressIndicatorBuilder: (context) =>
            LoadingCircularProgressIndicator(),
        newPageProgressIndicatorBuilder: (context) =>
            LoadingCircularProgressIndicator(),
        firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
          error: _pagingController.error,
          onTryAgain: () => _pagingController.refresh(),
        ),
        noItemsFoundIndicatorBuilder: (context) => EmptyListIndicator(
          title: '${AppLocalizations.of(context)!.empty_list}', //
          message: '${AppLocalizations.of(context)!.empty_list}', //
        ),
      ),
      padding: EdgeInsets.only(left: 20, right: 20),
      separatorBuilder: (context, index) => SizedBox(
        height: 4.h,
      ),
    );
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
      // ignore: dead_code
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      var parameters = {'q': _search};

      parameters.putIfAbsent(EndPointParameter.PAGE, () => pageKey.toString());
      parameters[EndPointParameter.PAGE] = pageKey.toString();

      var items = await locator<ActorsRepository>().fetchActorsList(parameters);

      if (items.isEmpty) {
        _pagingController.appendLastPage(items);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(items, nextPageKey);
      }
    } catch (error) {
      print(error);
      _pagingController.error = error;
    }
  }
}
