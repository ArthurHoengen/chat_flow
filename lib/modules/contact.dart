class Contact {
  String id;
  String name;
  String email;
  String number;

  Contact({
    this.id = '',
    required this.name,
    required this.email,
    required this.number,
  });

  Map<String,dynamic> toJson() => {
    'id':id,
    'name':name,
    'email':email,
    'number':number,
  };

  static Contact fromJson(Map<String, dynamic> json) => Contact(
    id: json['id'],
    email: json['email'],
    name: json['name'],
    number: json['number'],
  );
}