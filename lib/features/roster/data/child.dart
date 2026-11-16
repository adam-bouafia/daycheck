/// A child on the roster, and who is allowed to drop off or pick them up.
class Child {
  const Child({required this.id, required this.name, required this.guardians});

  final String id;
  final String name;
  final List<String> guardians;

  Map<String, Object?> toJson() => {
    'id': id,
    'name': name,
    'guardians': guardians,
  };

  factory Child.fromJson(Map<String, dynamic> json) => Child(
    id: json['id'] as String,
    name: json['name'] as String,
    guardians: (json['guardians'] as List).cast<String>(),
  );
}
