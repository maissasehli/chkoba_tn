import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String id,
    required String name,
    required String email,
    String? avatarUrl,
    required String provider,
  }) : super(
          id: id,
          name: name,
          email: email,
          avatarUrl: avatarUrl,
          provider: provider,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      provider: json['provider'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'provider': provider,
    };
  }

  factory UserModel.guest() {
    return UserModel(
      id: 'guest_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Invité',
      email: 'guest@chkoba.tn',
      provider: 'guest',
    );
  }
}
