import 'package:hive_flutter/hive_flutter.dart';
import 'hive_service.dart';

class HiveImpl implements HiveService {
  static HiveImpl? _instance;
  static var _init;
  static Box? _settings_box;
  static Box? _movie_box;
  static Box? _favorites_box;

  static Future<HiveImpl?> getInstance() async {
    await Hive.initFlutter();
    _instance ??= HiveImpl();
    _init ??= Hive.initFlutter();
    await Hive.openBox('settings');
    await Hive.openBox('movie');

    await Hive.openBox('favorites');

    _settings_box = Hive.box('settings');
    _movie_box = Hive.box('movie');

    _favorites_box = Hive.box('favorites');

    return _instance;
  }

  @override
  Box? get settings_box => _settings_box;

  @override
  Box? get movie_box => _movie_box;

  @override
  Box? get favorites_box => _favorites_box;

  @override
  set settings_box(Box? _settings_box) {
    // TODO: implement settings_box
  }

  @override
  set movie_box(Box? _movie_box) {
    // TODO: implement favorites_box
  }

  @override
  set favorites_box(Box? _favorites_box) {
    // TODO: implement favorites_box
  }
}
