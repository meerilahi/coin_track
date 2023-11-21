class AuthUserEntity {
  const AuthUserEntity({
    required this.isEmailVerified,
    required this.email,
    required this.userId,
  });
  final String userId;
  final String? email;
  final bool isEmailVerified;

  @override
  String toString() =>
      'AuthUserEntity(userId: $userId, email: $email, isEmailVerified: $isEmailVerified)';

  @override
  bool operator ==(covariant AuthUserEntity other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.email == email &&
        other.isEmailVerified == isEmailVerified;
  }

  @override
  int get hashCode =>
      userId.hashCode ^ email.hashCode ^ isEmailVerified.hashCode;
}
