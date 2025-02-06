class SessionUser {
  int? id;
  String? userUid;
  String? userNick;
  String? userProfile;
  String? accessToken;
  bool isLogined;

  SessionUser({
    required this.id,
    required this.userUid,
    required this.userNick,
    required this.userProfile,
    required this.accessToken,
    required this.isLogined,
  });
}
