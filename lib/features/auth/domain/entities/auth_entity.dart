class AuthEntity {
  final String? username;
  final String? email;
  final String? role;
  final String? password;
  final String? accessToken;
  final String? refreshToken;

  AuthEntity({
    this.email,
    this.username,
    this.role,
    this.password,
    this.accessToken,
    this.refreshToken,
  });
}
