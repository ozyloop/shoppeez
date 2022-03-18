class Ingredient{
  String name;
  String type;
  String imageUrl;
  int quantity;
  String quantityType;

  Ingredient(this.name, this.type, this.imageUrl, this.quantity, this.quantityType);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'imageUrl': imageUrl,

      'quantity': quantity,
      'quantityType': quantityType,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) => new Ingredient(
    map['name'],
    map['type'],
    map['imageUrl'],
    map['quantity'],
    map['quantityType'],


  );

}