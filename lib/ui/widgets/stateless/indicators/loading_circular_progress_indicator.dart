import 'package:flutter/material.dart';

class LoadingCircularProgressIndicator extends StatelessWidget {
  const LoadingCircularProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: Theme.of(context).colorScheme.onPrimary,
      backgroundColor: Theme.of(context).colorScheme.primary,
    ));
  }
}
