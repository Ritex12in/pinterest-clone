class AppUser {
  final String id;
  final String name;
  final String? avatar;

  AppUser({
    required this.id,
    required this.name,
    this.avatar,
  });
}