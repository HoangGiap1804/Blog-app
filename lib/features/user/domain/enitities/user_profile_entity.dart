class UserProfileEntity {
  final String id;
  final String username;
  final String email;
  final String role;
  final String? firstName;
  final String? lastName;
  final String? webSite;
  final String? facebook;
  final String? instagram;
  final String? x;
  final String? youtube;

  UserProfileEntity({
    required this.id,
    required this.username,
    required this.role,
    required this.email,
    this.firstName,
    this.lastName,
    this.webSite,
    this.facebook,
    this.instagram,
    this.x,
    this.youtube,
  });
}
