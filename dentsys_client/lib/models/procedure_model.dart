class Procedure {
  final int? id;
  final String name;
  final String priceType;
  final String category;
  final double basePrice;

  Procedure({
    this.id,
    required this.name,
    required this.priceType,
    required this.category,
    required this.basePrice,
  });

  Map<String, dynamic> toJson() {
    return {
      "prcd_name": name,
      "prcd_priceType": priceType,
      "prcd_category": category,
      "prcd_basePrice": basePrice,
    };
  }

  factory Procedure.fromJson(Map<String, dynamic> json) {
    return Procedure(
      id: json['prcd_id'],
      name: json['prcd_name'],
      priceType: json['prcd_priceType'],
      category: json['prcd_category'],
      basePrice: double.parse(json['prcd_basePrice'].toString()),
    );
  }
}
