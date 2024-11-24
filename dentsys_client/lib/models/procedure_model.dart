class Procedure {
  final int? id;
  final String name;
  final String priceType;
  final String category;
  final double basePrice;
  final double? minDP;

  Procedure({
    this.id,
    required this.name,
    required this.priceType,
    required this.category,
    required this.basePrice,
    this.minDP
  });

  @override
  String toString() {
  return '''
    Procedure {
      id: $id,
      name: $name,
      priceType: $priceType,
      category: $category,
      basePrice: $basePrice,
      minDP: $minDP
    }
  ''';  
  }

  Map<String, dynamic> toJson() {
    return {
      "prcd_id": id,
      "prcd_name": name,
      "prcd_priceType": priceType,
      "prcd_category": category,
      "prcd_basePrice": basePrice,
      "prcd_minDP": minDP
    };
  }

  factory Procedure.fromJson(Map<String, dynamic> json) {
    final procedureData = json['newProcedure'] != null ? json['newProcedure'][0] : json;
    // print('Procedure.fromJson: $procedureData');
    return Procedure(
      id: procedureData['prcd_id'],
      name: procedureData['prcd_name'],
      priceType: procedureData['prcd_priceType'],
      category: procedureData['prcd_category'],
      basePrice: double.parse(procedureData['prcd_basePrice'].toString()),
      minDP: double.tryParse(procedureData['prcd_minDP'].toString())
    );
  }
}
