class ChallengeDetail {
  String name;
  bool check;

  ChallengeDetail({
    required this.name,
    this.check = false,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "check": check,
    };
  }
}
