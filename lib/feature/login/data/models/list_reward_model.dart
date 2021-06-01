class ListRewardModel {
  final String name;
  final String from;
  final int price;

  ListRewardModel({
    required this.name,
    required this.from,
    required this.price,
  });

  ListRewardModel.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          from: json['from']! as String,
          price: json['price']! as int,
        );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'from': from,
      'price': price,
    };
  }
}
