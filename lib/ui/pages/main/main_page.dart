import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movieapp_flutter/core/services/navigation/navigation_service.dart';
import 'package:movieapp_flutter/locator.dart';
import 'package:movieapp_flutter/ui/router.gr.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../widgets/stateless/drawer/custom_drawer.dart';
import '../actors/actors_page.dart';
import '../home/home_page.dart';

class MainPageView extends StatefulWidget {
  @override
  _MainPageViewState createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  final _views = [
    HomePageView(),
    ActorsListView(),
  ];

  @override
  void dispose() {
    super.dispose();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    _selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _views.length,
      child: StatefulBuilder(
        builder: (context, setState) {
          return Scaffold(
            drawer: Drawer(
              width: 300,
              elevation: 0,
              child: CustomDrawer(),
            ),
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              iconTheme:
                  IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
              elevation: 0,
              title: Center(
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                    ),
                    Container(
                        alignment: AlignmentDirectional.topEnd,
                        child: InkWell(
                          onTap: () {
                            locator<NavigationService>()
                                .pushNamed(SearchPageViewRoute(), context);
                          },
                          child: Icon(
                            Icons.search,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        )),
                  ],
                ),
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            body: Center(
              // child: _views.elementAt(_selectedIndex)
              child: IndexedStack(
                  sizing: StackFit.expand,
                  index: _selectedIndex,
                  children: [
                    HomePageView(),
                    ActorsListView(),
                  ]),
            ),
            bottomNavigationBar: SalomonBottomBar(
              currentIndex: _selectedIndex,
              onTap: (i) {
                setState(
                  () {
                    _onItemTapped(i);
                  },
                );
              },
              items: [
                /// Home
                SalomonBottomBarItem(
                  icon: Icon(Icons.home_outlined),
                  title: Text(AppLocalizations.of(context)!.home),
                  selectedColor: Colors.red,
                ),

                /// Likes
                SalomonBottomBarItem(
                  icon: Icon(Icons.people_alt_outlined),
                  title: Text(AppLocalizations.of(context)!.actors),
                  selectedColor: Colors.blue,
                ),

                /// Profile
              ],
            ),
          );
        },
      ),
    );
  }
}
