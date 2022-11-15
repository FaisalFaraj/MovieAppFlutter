import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../business_logic/bloc/movie_list_bloc/movies_list_bloc.dart';
import '../../../core/constant/end_point_parameters.dart';
import '../../../core/models/genre/genre.dart';
import '../../../core/models/movie/movie.dart';
import '../../../core/repositories/movies_repository/movies_repository.dart';
import '../../../locator.dart';
import '../../widgets/pages_widgets/movie_card.dart';
import '../../widgets/stateless/indicators/empty_list_indicator.dart';
import '../../widgets/stateless/indicators/error_indicator.dart';
import '../../widgets/stateless/indicators/loading_circular_progress_indicator.dart';
import '../../widgets/stateless/indicators/no_internet_connection.dart';

class SearchMovies extends StatefulWidget {
  SearchMovies();

  @override
  _SearchMoviesState createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  List current_movies = [];
  DateTime? _selected_date;
  String? selected_genre;

  final List<List<String>> rates_items = [
    ['⭐'],
    ['⭐', '⭐'],
    ['⭐', '⭐', '⭐'],
    ['⭐', '⭐', '⭐', '⭐'],
    ['⭐', '⭐', '⭐', '⭐', '⭐']
  ];

  String? selected_rate;

  final MoviesListBloc _newsBloc = MoviesListBloc();

  final TextEditingController _textFieldController = TextEditingController();
  String? search_q;

  final ScrollController? controller = ScrollController();

  final _pagingController = PagingController<int, Movie>(
    firstPageKey: 1,
  );
  List temp_list = [];
  String _search = '';
  @override
  void initState() {
    _newsBloc.add(GetMoviesList());
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
  void didUpdateWidget(SearchMovies oldWidget) {
    _pagingController.refresh();
    super.didUpdateWidget(oldWidget);
  }

  Widget _build() {
    return Container(
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<MoviesListBloc, MoviesListState>(
          listener: (context, state) {
            if (state is MoviesListError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<MoviesListBloc, MoviesListState>(
            builder: (context, state) {
              if (state is MoviesListInitial) {
                return LoadingCircularProgressIndicator();
              } else if (state is MoviesListLoading) {
                return LoadingCircularProgressIndicator();
              } else if (state is MoviesListLoaded) {
                return _body(context, state.movies_list, state.genres_list);
              } else if (state is MoviesListError) {
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

  Widget _body(
      BuildContext context, List<Movie> movies_list, List<Genre> genres_list) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        filter_sections_movies(movies_list, genres_list),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 10,
          child: TextField(
            maxLines: 1,
            controller: _textFieldController,
            onChanged: (value) {
              _search = value;
              _pagingController.refresh();
            },
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
        Expanded(
          // {
          //     if (_textFieldController.text.isNotEmpty) 'q': search_q,
          //   }, onMoviesClicked: (move) {}
          child: _pagedListView(),
        )
      ],
    );
  }

  Widget filter_sections_movies(
      List<Movie> movies_list, List<Genre> genres_list) {
    return Row(
      children: [
        SizedBox(width: 2.h),
        Expanded(
          child: InkWell(
            child: Container(
              height: 6.h,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 30, 95, 148),
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(25), right: Radius.circular(25))),
              child: Icon(
                Icons.event_note,
                color: Colors.white,
                size: 25.sp,
              ),
            ),
            onTap: () async {
              await _selectDate(context);
              date_filter_movies(movies_list, _selected_date);
            },
          ),
        ),
        SizedBox(
          width: 2.h,
        ),
        Expanded(
          child: MultiSelectDialogField(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 133, 21, 68),
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(25), right: Radius.circular(25))),
            buttonText: Text(AppLocalizations.of(context)!.genre,
                style: TextStyle(fontSize: 15.sp, color: Colors.white)),
            buttonIcon: Icon(
              Icons.sort_outlined,
              color: Colors.white,
            ),
            title: Text(AppLocalizations.of(context)!.genre,
                style: TextStyle(
                    fontSize: 20.sp,
                    color: Theme.of(context).colorScheme.onPrimary)),
            confirmText: Text(AppLocalizations.of(context)!.confirm,
                style: TextStyle(fontSize: 17.sp, color: Colors.blue)),
            cancelText: Text(AppLocalizations.of(context)!.cancel,
                style: TextStyle(fontSize: 17.sp, color: Colors.blue)),
            selectedColor: Colors.blue,
            unselectedColor: Theme.of(context).colorScheme.primaryContainer,
            itemsTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
            ),
            selectedItemsTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
            ),
            items: genres_list
                .map((genre) => MultiSelectItem(genre.name!, genre.name!))
                .toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {
              genre_filter_movies(movies_list, values.toString());
            },
          ),
        ),
        SizedBox(
          width: 2.h,
        ),
        Expanded(
          child: Container(
            child: MultiSelectDialogField(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 190, 53, 11),
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(25), right: Radius.circular(25))),
              buttonText: Text(AppLocalizations.of(context)!.rate,
                  style: TextStyle(fontSize: 15.sp, color: Colors.white)),
              title: Text(AppLocalizations.of(context)!.rate,
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: Theme.of(context).colorScheme.onPrimary)),
              buttonIcon: Icon(
                Icons.sort_outlined,
                color: Colors.white,
              ),
              confirmText: Text(AppLocalizations.of(context)!.confirm,
                  style: TextStyle(fontSize: 17.sp, color: Colors.blue)),
              cancelText: Text(AppLocalizations.of(context)!.cancel,
                  style: TextStyle(fontSize: 17.sp, color: Colors.blue)),
              selectedColor: Colors.blue,
              unselectedColor: Theme.of(context).colorScheme.primaryContainer,
              itemsTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),
              selectedItemsTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
              ),
              items: rates_items
                  .map((rate) => MultiSelectItem(rate.length, rate.join()))
                  .toList(),
              listType: MultiSelectListType.CHIP,
              onConfirm: (values) {
                rate_filter_movies(movies_list, values.toString());
              },
            ),
          ),
        ),
        SizedBox(width: 2.h),
      ],
    );
  }

  Widget _pagedListView() {
    return PagedListView.separated(
      physics: BouncingScrollPhysics(),
      scrollController: controller,
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Movie>(
        itemBuilder: (context, movie, index) {
          if (temp_list.length == 3) {
            var tem_list2 = List.from(temp_list);
            temp_list.clear();

            return Row(
              children: [
                for (var v in tem_list2)
                  Expanded(
                    child: MovieCard(v),
                  ),
              ],
            );
          } else {
            temp_list.add(movie);
            return SizedBox.shrink();
          }
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
          title: '${AppLocalizations.of(context)!.empty_list}',
          message: '${AppLocalizations.of(context)!.empty_list}',
        ),
      ),
      padding: EdgeInsets.only(left: 10, right: 10),
      separatorBuilder: (context, index) => SizedBox(
        height: 1.h,
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
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      var parameters = {'q': _search};
      parameters.putIfAbsent(EndPointParameter.PAGE, () => pageKey.toString());
      parameters[EndPointParameter.PAGE] = pageKey.toString();

      var items = await locator<MoviesRepository>().fetchMoviesList(parameters);

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

  Future<void> _selectDate(BuildContext context) async {
    _selected_date = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary, // <-- SEE HERE
              onPrimary: Colors.blue, // <-- SEE HERE
              onSurface:
                  Theme.of(context).colorScheme.onPrimary, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.blue, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ));
  }

  void date_filter_movies(List<Movie> movies_list, DateTime? date) {
    //TODO
    current_movies.clear();
    for (var g in movies_list) {
      if (g.release_date!.year == date!.year) {
        current_movies.add(g);
      }
      ;
    }
    ;
  }

  void genre_filter_movies(List<Movie> movies_list, String value) {
    //TODO
    selected_genre = value;
    ;
  }

  void rate_filter_movies(List<Movie> movies_list, String value) {
    //TODO
    selected_rate = value;
    ;
  }
}
