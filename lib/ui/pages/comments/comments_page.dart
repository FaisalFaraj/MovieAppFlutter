import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:movieapp_flutter/core/services/hive/hive_service.dart';
import 'package:movieapp_flutter/locator.dart';
import '../../../core/models/movie/movie.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:rate/rate.dart';
import 'package:toggle_list/toggle_list.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:twemoji/twemoji.dart';
import 'package:sizer/sizer.dart';
import '../../../business_logic/bloc/movie_list_bloc/movies_list_bloc.dart';

// ignore: must_be_immutable
class CommentsScreenView extends StatefulWidget {
  final String? movie_id;
  Movie movie;
  CommentsScreenView(this.movie_id, this.movie);

  @override
  _CommentsScreenViewState createState() => _CommentsScreenViewState();
}

class _CommentsScreenViewState extends State<CommentsScreenView> {
  @override
  void didUpdateWidget(CommentsScreenView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  final MoviesListBloc _newsBloc = MoviesListBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var movie_box = locator<HiveService>().movie_box!;

  late List comment_list;
  List random_avater = [];
  TextEditingController comment_controller = TextEditingController();
  double selected_rate = 1;
  void update_comments() {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      dynamic list_vaules;

      var value = {
        'comment': comment_controller.text,
        'selected_rate': selected_rate,
        'user': '0',
      };
      comment_controller.clear();
      if (movie_box.get(widget.movie_id.toString()) != null) {
        list_vaules = movie_box.get(widget.movie_id.toString());

        list_vaules.add(value);

        movie_box.put(widget.movie_id.toString(), list_vaules);
      } else {
        movie_box.put(widget.movie_id.toString(), [value]);
      }

      random_avater.add(randomAvatarString(DateTime.now().toIso8601String()));
    });
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
              return _body(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _body(
    BuildContext context,
  ) {
    return Stack(
      children: [
        ToggleList(
          divider: const SizedBox(height: 10),
          toggleAnimationDuration: const Duration(milliseconds: 200),
          scrollDuration: const Duration(milliseconds: 350),
          children: [
            for (int item = 0; item < comment_list.length; item++)
              ToggleListItem(
                title: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 15, bottom: 15),
                  child: Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 24, 23, 23),
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(20),
                              left: Radius.circular(20))),
                      child: Row(children: [
                        SvgPicture.string(random_avater[item], width: 120,
                            placeholderBuilder: (context) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.onPrimary,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                          );
                        }),
                        SizedBox(width: 60),
                        Column(children: [
                          Text(
                            'Faisal Faraj',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Rate(
                            iconSize: 20,
                            color: Theme.of(context).colorScheme.secondary,
                            allowHalf: true,
                            allowClear: true,
                            initialValue: comment_list[item]['selected_rate'],
                            readOnly: true,
                            onChange: (value) {},
                          )
                        ])
                      ])),
                ),
                content: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            end: 40, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: ReactionButton(
                                  boxPosition: VerticalPosition.TOP,
                                  boxHorizontalPosition:
                                      HorizontalPosition.CENTER,
                                  boxPadding: EdgeInsets.all(20),
                                  boxColor: Colors.transparent,
                                  boxReactionSpacing: 30,
                                  onReactionChanged: (value) {},
                                  reactions: [
                                    Reaction(
                                        icon: Twemoji(
                                          emoji: '😍',
                                          height: 30,
                                          width: 30,
                                        ),
                                        value: 3),
                                    Reaction(
                                        icon: Twemoji(
                                          emoji: '😡',
                                          height: 30,
                                          width: 30,
                                        ),
                                        value: 3),
                                    Reaction(
                                        icon: Twemoji(
                                          emoji: '😂',
                                          height: 30,
                                          width: 30,
                                        ),
                                        value: 3),
                                    Reaction(
                                        icon: Twemoji(
                                          emoji: '🤗',
                                          height: 30,
                                          width: 30,
                                        ),
                                        value: 3)
                                  ]),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.reply,
                                size: 30,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        comment_list[item]['comment'],
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 140,
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              children: [
                TextField(
                  maxLines: 2,
                  controller: comment_controller,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 13.sp),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(20),
                            right: Radius.circular(20)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(20),
                            right: Radius.circular(20)),
                        borderSide: BorderSide(
                          width: 0,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.primaryContainer,
                      suffixIcon: Icon(Icons.search,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer)),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Rate(
                        iconSize: 35,
                        color: Theme.of(context).colorScheme.secondary,
                        allowHalf: true,
                        allowClear: true,
                        initialValue: 1,
                        readOnly: false,
                        onChange: (rating) {
                          selected_rate = rating;
                        },
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsetsDirectional.only(end: 15),
                      height: 50,
                      width: 50,
                      child: InkWell(
                        onTap: () {
                          update_comments();
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.blue,
                          size: 45,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (movie_box.get(widget.movie_id.toString()) != null) {
      comment_list = movie_box.get(widget.movie_id.toString());

      for (var i = 0; i < comment_list.length; i++) {
        random_avater.add(randomAvatarString(
          DateTime.now().toIso8601String(),
        ));
      }
    } else {
      comment_list = [];
    }

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary, body: _build());
  }
}
