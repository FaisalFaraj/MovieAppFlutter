import 'package:hive/hive.dart';

abstract class HiveService {
  Box? settings_box;

  Box? favorites_box;
  Box? movie_box;
}
