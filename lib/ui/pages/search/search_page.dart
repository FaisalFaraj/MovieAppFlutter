import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'search_actors.dart';
import 'search_movies.dart';

class SearchPageView extends StatefulWidget {
  SearchPageView();

  @override
  _SearchPageViewState createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView>
    with SingleTickerProviderStateMixin {
  @override
  void didUpdateWidget(SearchPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        toolbarHeight: 10,
        bottom: TabBar(
          splashBorderRadius: BorderRadius.horizontal(
              right: Radius.circular(20), left: Radius.circular(20)),
          controller: _tabController,
          indicatorColor: Theme.of(context).colorScheme.onPrimary,
          tabs: [
            Tab(
              text: AppLocalizations.of(context)!.movies,
            ),
            Tab(
              text: AppLocalizations.of(context)!.actors,
            ),
          ],
          labelColor: Theme.of(context).colorScheme.onPrimary,
          indicator: DotIndicator(
            color: Theme.of(context).colorScheme.onPrimary,
            distanceFromCenter: 16,
            radius: 3,
            paintingStyle: PaintingStyle.fill,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: TabBarView(
        controller: _tabController,
        children: [
          SearchMovies(),
          SearchActors(),
        ],
      ),
    );
  }
}
