class Item {
  String name;
  bool check;
  String type;

  Item({required this.name, this.check = false, required this.type});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "check": check,
      "type": type,
    };
  }
}
