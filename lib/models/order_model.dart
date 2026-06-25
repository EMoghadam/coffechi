import 'package:flutter/material.dart';

// ============================================================
// مدل‌های جدید بر اساس API (برای لیست و جزییات سفارش)
// ============================================================

// آیتم سفارش در لیست
class OrderItemDto {
  final int id;
  final String name;
  final int count;
  final double amount;
  final double totalAmount;

  OrderItemDto({
    required this.id,
    required this.name,
    required this.count,
    required this.amount,
    required this.totalAmount,
  });

  factory OrderItemDto.fromJson(Map<String, dynamic> json) {
    return OrderItemDto(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      count: json['count'] ?? 0,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

// نظر ثبت شده برای سفارش
class CommentDto {
  final int id;
  final String text;
  final int point;

  CommentDto({
    required this.id,
    required this.text,
    required this.point,
  });

  factory CommentDto.fromJson(Map<String, dynamic> json) {
    return CommentDto(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
      point: json['point'] ?? 0,
    );
  }
}

// مدل وضعیت سفارش (Object)
class OrderStatus {
  final int id;
  final String name;

  OrderStatus({
    required this.id,
    required this.name,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'نامشخص',
    );
  }
}

// مدل کامل سفارش از سرور (برای لیست و جزییات)
class OrderListResponse {
  final int id;
  final int customerId;
  final String customerName;
  final int cafeResturantId;
  final String cafeResturantName;
  final double amount;
  final String creationDate;
  final List<OrderItemDto> orderItemDtoList;
  final OrderStatus status;
  final CommentDto? commentDto;

  OrderListResponse({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.cafeResturantId,
    required this.cafeResturantName,
    required this.amount,
    required this.creationDate,
    required this.orderItemDtoList,
    required this.status,
    this.commentDto,
  });

  factory OrderListResponse.fromJson(Map<String, dynamic> json) {
    return OrderListResponse(
      id: json['id'] ?? 0,
      customerId: json['customerId'] ?? 0,
      customerName: json['customerName'] ?? '',
      cafeResturantId: json['cafeResturantId'] ?? 0,
      cafeResturantName: json['cafeResturantName'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      creationDate: json['creationDate'] ?? '',
      orderItemDtoList: (json['orderItemDtoList'] as List?)
          ?.map((e) => OrderItemDto.fromJson(e))
          .toList() ?? [],
      status: OrderStatus.fromJson(json['status'] ?? {'id': 0, 'name': 'نامشخص'}),
      commentDto: json['commentDto'] != null
          ? CommentDto.fromJson(json['commentDto'])
          : null,
    );
  }

  String get statusPersian {
    switch (status.id) {
      case 1:
        return 'جدید';
      case 2:
        return 'در حال آماده‌سازی';
      case 3:
        return 'تحویل شده';
      case 4:
        return 'لغو شده';
      default:
        return status.name;
    }
  }

  Color get statusColor {
    switch (status.id) {
      case 1:
        return Colors.orange;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.green;
      case 4:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
  String get formattedDate {
    try {
      final date = DateTime.parse(creationDate);
      return '${date.year}/${date.month}/${date.day} - ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return creationDate;
    }
  }

  // متد برای دریافت مبلغ به صورت int (برای نمایش)
  int get amountInt => amount.toInt();
}

// ============================================================
// مدل‌های قدیمی (برای ثبت سفارش و سبد خرید)
// ============================================================

// مدل آیتم سفارش برای ارسال به سرور
class OrderItemRequest {
  final int menuItemId;
  final int count;

  OrderItemRequest({
    required this.menuItemId,
    required this.count,
  });

  Map<String, dynamic> toJson() {
    return {
      'menuItemId': menuItemId,
      'count': count,
    };
  }
}

// مدل درخواست ثبت سفارش
class CreateOrderRequest {
  final String customerPhoneNumber;
  final List<OrderItemRequest> itemList;

  CreateOrderRequest({
    required this.customerPhoneNumber,
    required this.itemList,
  });

  Map<String, dynamic> toJson() {
    return {
      'customerPhoneNumber': customerPhoneNumber,
      'itemList': itemList.map((e) => e.toJson()).toList(),
    };
  }
}

// مدل آیتم سبد خرید (برای UI)
class CartItem {
  final int menuItemId;
  final String name;
  final double price;
  int quantity;

  CartItem({
    required this.menuItemId,
    required this.name,
    required this.price,
    required this.quantity,
  });
}

// مدل ثبت نظر
class AddCommentRequest {
  final int orderId;
  final String text;
  final int point;

  AddCommentRequest({
    required this.orderId,
    required this.text,
    required this.point,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'text': text,
      'point': point,
    };
  }
}

// ============================================================
// مدل‌های قدیمی (برای سازگاری - در صورت نیاز)
// ============================================================

class OrderResponse {
  final int id;
  final String restaurantName;
  final String restaurantImage;
  final String status;
  final String date;
  final int price;
  final List<OrderItemDetail> items;
  final String address;

  OrderResponse({
    required this.id,
    required this.restaurantName,
    required this.restaurantImage,
    required this.status,
    required this.date,
    required this.price,
    required this.items,
    required this.address,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      id: json['id'] ?? 0,
      restaurantName: json['restaurantName'] ?? '',
      restaurantImage: json['restaurantImage'] ?? '',
      status: json['status'] ?? '',
      date: json['date'] ?? '',
      price: json['price'] ?? 0,
      items: (json['items'] as List?)
          ?.map((e) => OrderItemDetail.fromJson(e))
          .toList() ?? [],
      address: json['address'] ?? '',
    );
  }
}

class OrderItemDetail {
  final String name;
  final int count;
  final int price;

  OrderItemDetail({
    required this.name,
    required this.count,
    required this.price,
  });

  factory OrderItemDetail.fromJson(Map<String, dynamic> json) {
    return OrderItemDetail(
      name: json['name'] ?? '',
      count: json['count'] ?? 0,
      price: json['price'] ?? 0,
    );
  }
}