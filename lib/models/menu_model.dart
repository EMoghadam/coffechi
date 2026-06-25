class MenuItem {
  final int id;
  final String name;
  final double amount;

  MenuItem({
    required this.id,
    required this.name,
    required this.amount,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      name: json['name'],
      amount: (json['amount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
    };
  }
}

class MenuCategory {
  final int id;
  final String title;
  final List<MenuItem> itemList;

  MenuCategory({
    required this.id,
    required this.title,
    this.itemList = const [],
  });

  factory MenuCategory.fromJson(Map<String, dynamic> json) {
    return MenuCategory(
      id: json['id'],
      title: json['title'],
      itemList: (json['itemList'] as List?)
          ?.map((item) => MenuItem.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'itemList': itemList.map((e) => e.toJson()).toList(),
    };
  }
}

// برای درخواست ایجاد منو
class CreateMenuRequest {
  final String title;

  CreateMenuRequest({required this.title});

  Map<String, dynamic> toJson() {
    return {'title': title};
  }
}

// برای درخواست حذف منو
class DeleteMenuRequest {
  final int menuId;

  DeleteMenuRequest({required this.menuId});

  Map<String, dynamic> toJson() {
    return {'menuId': menuId};
  }
}

// برای درخواست ویرایش منو
class EditMenuRequest {
  final int menuId;
  final String title;

  EditMenuRequest({required this.menuId, required this.title});

  Map<String, dynamic> toJson() {
    return {'menuId': menuId, 'title': title};
  }
}

// برای درخواست ایجاد آیتم منو
class CreateMenuItemRequest {
  final int menuId;
  final String name;
  final double amount;

  CreateMenuItemRequest({
    required this.menuId,
    required this.name,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'menuId': menuId,
      'name': name,
      'amount': amount,
    };
  }
}

// برای درخواست حذف آیتم منو
class DeleteMenuItemRequest {
  final int menuItemId;

  DeleteMenuItemRequest({required this.menuItemId});

  Map<String, dynamic> toJson() {
    return {'menuItemId': menuItemId};
  }
}

// برای درخواست ویرایش آیتم منو
class EditMenuItemRequest {
  final int menuItemId;
  final String name;
  final double amount;

  EditMenuItemRequest({
    required this.menuItemId,
    required this.name,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'menuItemId': menuItemId,
      'name': name,
      'amount': amount,
    };
  }
}