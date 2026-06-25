// مدل رستوران برای جستجو
class SearchRestaurant {
  final int id;
  final String name;
  final String workTime;
  final String address;
  final String phoneNumber;
  final double point;
  final int pointCount;

  SearchRestaurant({
    required this.id,
    required this.name,
    required this.workTime,
    required this.address,
    required this.phoneNumber,
    required this.point,
    required this.pointCount,
  });

  factory SearchRestaurant.fromJson(Map<String, dynamic> json) {
    return SearchRestaurant(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      workTime: json['workTime'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      point: _toDoubleSafe(json['point']),
      pointCount: _toIntSafe(json['pointCount']),
    );
  }

  static double _toDoubleSafe(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) {
      if (value.isNaN || value.isInfinite) return 0.0;
      return value;
    }
    if (value is int) return value.toDouble();
    if (value is String) {
      final parsed = double.tryParse(value);
      if (parsed == null || parsed.isNaN || parsed.isInfinite) return 0.0;
      return parsed;
    }
    return 0.0;
  }

  static int _toIntSafe(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) {
      if (value.isNaN || value.isInfinite) return 0;
      return value.toInt();
    }
    if (value is String) {
      final parsed = double.tryParse(value);
      if (parsed == null || parsed.isNaN || parsed.isInfinite) return 0;
      return parsed.toInt();
    }
    return 0;
  }
}

// مدل غذا برای جستجو
class SearchFood {
  final int id;
  final String name;
  final double amount;
  final double point;
  final int pointCount;

  SearchFood({
    required this.id,
    required this.name,
    required this.amount,
    required this.point,
    required this.pointCount,
  });

  factory SearchFood.fromJson(Map<String, dynamic> json) {
    return SearchFood(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      amount: _toDoubleSafe(json['amount']),
      point: _toDoubleSafe(json['point']),
      pointCount: _toIntSafe(json['pointCount']),
    );
  }

  static double _toDoubleSafe(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) {
      if (value.isNaN || value.isInfinite) return 0.0;
      return value;
    }
    if (value is int) return value.toDouble();
    if (value is String) {
      final parsed = double.tryParse(value);
      if (parsed == null || parsed.isNaN || parsed.isInfinite) return 0.0;
      return parsed;
    }
    return 0.0;
  }

  static int _toIntSafe(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) {
      if (value.isNaN || value.isInfinite) return 0;
      return value.toInt();
    }
    if (value is String) {
      final parsed = double.tryParse(value);
      if (parsed == null || parsed.isNaN || parsed.isInfinite) return 0;
      return parsed.toInt();
    }
    return 0;
  }
}
// مدل جزییات کامل غذا (با کافه و نظرات)
class FoodDetailResponse {
  final SearchFood food;
  final int cafeResturantId;
  final String cafeResturantName;
  final List<Comment> commentList;

  FoodDetailResponse({
    required this.food,
    required this.cafeResturantId,
    required this.cafeResturantName,
    required this.commentList,
  });

  factory FoodDetailResponse.fromJson(Map<String, dynamic> json) {
    return FoodDetailResponse(
      food: SearchFood.fromJson(json['food'] ?? {}),
      cafeResturantId: json['cafeResturantId'] ?? 0,
      cafeResturantName: json['cafeResturantName'] ?? '',
      commentList: (json['commentList'] as List?)
          ?.map((e) => Comment.fromJson(e))
          .toList() ?? [],
    );
  }
}

// مدل نظر
class Comment {
  final int id;
  final String text;
  final int point;

  Comment({
    required this.id,
    required this.text,
    required this.point,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
      point: json['point'] ?? 0,
    );
  }
}
// مدل منو در جزییات رستوران
class RestaurantMenu {
  final int menuId;
  final String title;
  final List<RestaurantMenuItem> itemList;

  RestaurantMenu({
    required this.menuId,
    required this.title,
    required this.itemList,
  });

  factory RestaurantMenu.fromJson(Map<String, dynamic> json) {
    return RestaurantMenu(
      menuId: json['menuId'] ?? 0,
      title: json['title'] ?? '',
      itemList: (json['itemList'] as List?)
          ?.map((e) => RestaurantMenuItem.fromJson(e))
          .toList() ?? [],
    );
  }
}
// مدل آیتم منو در جزییات رستوران
class RestaurantMenuItem {
  final int id;
  final String name;
  final double amount;

  RestaurantMenuItem({
    required this.id,
    required this.name,
    required this.amount,
  });

  factory RestaurantMenuItem.fromJson(Map<String, dynamic> json) {
    print('🔍 RestaurantMenuItem JSON: $json'); // لاگ برای دیباگ

    // بررسی فیلدهای مختلف برای ID
    int id = json['id'] ?? 0;
    if (id == 0) {
      id = json['menuItemId'] ?? 0;  // بررسی فیلد menuItemId
    }
    if (id == 0) {
      id = json['foodId'] ?? 0;  // بررسی فیلد foodId
    }
    if (id == 0) {
      id = json['itemId'] ?? 0;  // بررسی فیلد itemId
    }

    return RestaurantMenuItem(
      id: id,
      name: json['name'] ?? '',
      amount: _toDoubleSafe(json['amount']),
    );
  }

  static double _toDoubleSafe(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) {
      if (value.isNaN || value.isInfinite) return 0.0;
      return value;
    }
    if (value is int) return value.toDouble();
    if (value is String) {
      final parsed = double.tryParse(value);
      if (parsed == null || parsed.isNaN || parsed.isInfinite) return 0.0;
      return parsed;
    }
    return 0.0;
  }
}
// مدل جزییات کامل رستوران
class RestaurantDetailResponse {
  final SearchRestaurant cafeResturant;
  final List<RestaurantMenu> menuList;

  RestaurantDetailResponse({
    required this.cafeResturant,
    required this.menuList,
  });

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailResponse(
      cafeResturant: SearchRestaurant.fromJson(json['cafeResturant'] ?? {}),
      menuList: (json['menuList'] as List?)
          ?.map((e) => RestaurantMenu.fromJson(e))
          .toList() ?? [],
    );
  }
}