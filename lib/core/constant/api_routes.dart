/// List of api end points
class ApiRoutes {
  ApiRoutes._();

  static String base_url = 'https://smdb.sadeem-lab.com/';
  static String v1 = 'api/v1';
  static String base = base_url + v1;

  static String movies = '$base/movies';
  static String actors = '$base/actors';
  static String genres = '$base/genres';

  static String genre(String? id) => '$base/genres/$id';
  static String actor(String? id) => '$base/actors/$id';

  static String movie(String? id) => '$base/movies/$id';
}
