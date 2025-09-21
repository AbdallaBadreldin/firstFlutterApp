class MyModel {
  int? id; // Nullable for auto-increment
  String name;
  int value;
  double num;

  MyModel({this.id, required this.name, required this.value, required this.num});

  // Convert a MyModel into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'num': num,
    };
  }

  // A factory constructor to create a MyModel from a Map
  factory MyModel.fromMap(Map<String, dynamic> map) {
    return MyModel(
      id: map['id'],
      name: map['name'],
      value: map['value'],
      num: map['num'],
    );
  }

  @override
  String toString() {
    return 'MyModel{id: $id, name: $name, value: $value, num: $num}';
  }
}