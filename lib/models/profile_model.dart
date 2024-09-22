class ProfileModel {
  final String name;
  final String username;
  final double pointBalance;
  final String email;
  ProfileModel(
      {required this.name,
      required this.username,
      required this.pointBalance,
      required this.email});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'point_balance': pointBalance,
      'email': email
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        name: json['name'],
        username: json['username'],
        pointBalance: json['point_balance'],
        email: json['email']);
  }
}
