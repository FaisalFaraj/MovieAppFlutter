import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movieapp_flutter/core/services/navigation/navigation_service.dart';
import 'package:movieapp_flutter/locator.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:movieapp_flutter/ui/router.gr.dart';
import 'package:movieapp_flutter/ui/widgets/stateless/drawer/custom_list_tile.dart';
import 'package:movieapp_flutter/ui/widgets/stateless/drawer/upper_user_info.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 0),
        width: 300,
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UpperUserInfo(),
            InkWell(
              onTap: () {
                locator<NavigationService>()
                    .pushNamed(FavoritesMoviesViewRoute(), context);
              },
              child: CustomListTile(
                icon_color: Colors.red,
                icon: Icons.favorite_outline,
                title: AppLocalizations.of(context)!.favorites,
                infoCount: 0,
              ),
            ),
            CustomListTile(
              icon_color: Colors.orange.shade600,
              icon: Icons.person,
              title: AppLocalizations.of(context)!.profile,
              infoCount: 2,
            ),
            InkWell(
              onTap: () {
                locator<NavigationService>()
                    .pushNamed(SettingsViewRoute(), context);
              },
              child: CustomListTile(
                icon_color: Colors.blue,
                icon: Icons.settings,
                title: AppLocalizations.of(context)!.settings,
                infoCount: 3,
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
