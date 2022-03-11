class Ingredient{
  String name;
  String type;
  String imageUrl;
  int quantity;


  Ingredient(this.name, this.type, this.imageUrl, this.quantity);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'imageUrl': imageUrl,

      'quantity': quantity,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) => new Ingredient(
    map['name'],
    map['type'],
    map['imageUrl'],
    map['quantity'],


  );

}