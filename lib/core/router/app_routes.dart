class AppRoutes {
  static const String login = '/login';
  static const String feed = '/feed';
  static const String search = '/search';
  static const String profile = '/profile';

  static const String pin = '/pin/:id';
  static String pinDetail(int id) => '/pin/$id';
}
