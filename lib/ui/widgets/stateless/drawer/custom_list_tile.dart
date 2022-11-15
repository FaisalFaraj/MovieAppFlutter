import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final Color icon_color;
  final String title;
  final IconData? doHaveMoreOptions;
  final int infoCount;

  const CustomListTile({
    Key? key,
    required this.icon,
    required this.title,
    this.doHaveMoreOptions,
    required this.infoCount,
    required this.icon_color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: 300,
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    icon,
                    color: icon_color,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 13.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
