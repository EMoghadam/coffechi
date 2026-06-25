import 'cafe_type.dart';

class ManagerProfile {
  final String name;
  final String phoneNumber;
  final String? workTime;
  final String? address;
  final List<CafeType> typeList;

  ManagerProfile({
    required this.name,
    required this.phoneNumber,
    this.workTime,
    this.address,
    this.typeList = const [],
  });

  factory ManagerProfile.fromJson(Map<String, dynamic> json) {
    return ManagerProfile(
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      workTime: json['workTime'],
      address: json['address'],
      typeList: (json['typeList'] as List?)
          ?.map((item) => CafeType.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      if (workTime != null) 'workTime': workTime,
      if (address != null) 'address': address,
      'typeList': typeList.map((e) => e.id).toList(),  // فقط idها برای ارسال
    };
  }
}

class UpdateProfileRequest {
  final String? name;
  final String? address;
  final String? phoneNumber;
  final String? workTime;
  final List<int>? typeList;  // لیست idها

  UpdateProfileRequest({
    this.name,
    this.address,
    this.phoneNumber,
    this.workTime,
    this.typeList,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (workTime != null) 'workTime': workTime,
      if (typeList != null) 'typeList': typeList,
    };
  }
}

// مدل مشتری (اگر نیاز شد)
class CustomerProfile {
  final String name;
  final String phoneNumber;

  CustomerProfile({
    required this.name,
    required this.phoneNumber,
  });

  factory CustomerProfile.fromJson(Map<String, dynamic> json) {
    return CustomerProfile(
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }
}