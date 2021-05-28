class AutoreItem {
  String? name;

  AutoreItem();

  factory AutoreItem.fromJSON(Map<String, dynamic> json) {
    var item = AutoreItem();

    item.name = json["name"];
    return item;
  }
}
