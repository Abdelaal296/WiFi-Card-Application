class MyData {
  final String card_id;
  final String network_id;
  final List<String> cards;

  MyData(
      {required this.card_id, required this.network_id, required this.cards});

  Map<String, dynamic> toJson(MyData myData) => {
        'card_category_id': card_id,
        'network_id': card_id,
        'card_numbers': cards,
      };
}
