class AppRoutes {
  static const String login = '/login';
  static const String feed = '/feed';
  static const String search = '/search';
  static const String profile = '/profile';
  static const String pin = '/pin/:id';
  static const messages = '/messages';

  static String pinDetail(int id) => '/pin/$id';
  static const String searchFeed = '/search/:query';
  static String searchResults(String query) => '/search/$query';
  static String searchInput({String? initialQuery}) {
    if (initialQuery == null || initialQuery.isEmpty) {
      return "/search-input";
    }
    return "/search-input?q=${Uri.encodeComponent(initialQuery)}";
  }

}
