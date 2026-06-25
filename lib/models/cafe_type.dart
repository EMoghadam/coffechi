class CafeType {
  final int id;
  final String name;  // بود title حالا شد name

  CafeType({required this.id, required this.name});

  factory CafeType.fromJson(Map<String, dynamic> json) {
    return CafeType(
      id: json['id'],
      name: json['name'],  // تغییر
    );
  }
}