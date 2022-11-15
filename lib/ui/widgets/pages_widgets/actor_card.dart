import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/models/actor/actor.dart';

class ActorCard extends StatelessWidget {
  final Actor actor;

  ActorCard(this.actor);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 15.h,
          width: 95.w,
          color: Theme.of(context).colorScheme.primary,
          alignment: AlignmentDirectional.bottomEnd,
          child: Container(
            height: 8.h,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10), bottom: Radius.circular(10))),
            alignment: AlignmentDirectional.centerEnd,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 10),
              child: Text(
                actor.name!,
                maxLines: 1,
                style: TextStyle(
                    height: 1.4,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0.sp),
              ),
            ),
          ),
        ),
        Container(
            height: 15.h,
            width: 33.w,
            child: CachedNetworkImage(
                imageUrl: actor.thumb!,
                imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onPrimary,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error))))
      ],
    );
  }
}
