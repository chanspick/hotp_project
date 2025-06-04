class UserProfile {
  final String uid;
  final String? displayName;

  UserProfile({required this.uid, this.displayName});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'] as String,
      displayName: json['displayName'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'displayName': displayName,
      };
}
