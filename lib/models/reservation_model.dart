import 'package:flutter/material.dart';

class Reservation {
  final int id;
  final int cafeResturantId;
  final int customerId;
  final int customerCount;
  final String title; // ⭐ اضافه شد (نام کافه/رستوران)
  final String reservationDate;
  final String creationDate;
  final String request;
  final String? answer;
  final int statusId;
  final String statusName;
  String? customerName;
  String? customerPhone;

  Reservation({
    required this.id,
    required this.cafeResturantId,
    required this.customerId,
    required this.customerCount,
    required this.title, // ⭐ اضافه شد
    required this.reservationDate,
    required this.creationDate,
    required this.request,
    this.answer,
    required this.statusId,
    required this.statusName,
    this.customerName,
    this.customerPhone,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      cafeResturantId: json['cafeResturantId'],
      customerId: json['customerId'],
      customerCount: json['customerCount'],
      title: json['title'] ?? '', // ⭐ اضافه شد
      reservationDate: json['reservationDate'],
      creationDate: json['creationDate'],
      request: json['request'] ?? '',
      answer: json['answer'],
      statusId: json['statusId'],
      statusName: json['statusName'] ?? _getStatusNameFromId(json['statusId']),
    );
  }

  static String _getStatusNameFromId(int? id) {
    switch (id) {
      case 1: return 'جدید';
      case 2: return 'تایید شده';
      case 3: return 'رد شده';
      default: return 'نامشخص';
    }
  }

  String getPersianDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return '${date.year}/${date.month}/${date.day}';
    } catch (e) {
      return isoDate;
    }
  }

  String getPersianTime(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return '';
    }
  }

  // متدهای کمکی جدید
  String get statusPersian {
    switch (statusName) {
      case 'Pending':
        return 'در انتظار تایید';
      case 'Accepted':
        return 'تایید شده';
      case 'Rejected':
        return 'رد شده';
      default:
        return statusName;
    }
  }

  Color get statusColor {
    switch (statusName) {
      case 'Pending':
        return Colors.orange;
      case 'Accepted':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String get formattedReservationDate {
    try {
      final date = DateTime.parse(reservationDate);
      return '${date.year}/${date.month}/${date.day} - ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return reservationDate;
    }
  }

  String get formattedCreationDate {
    try {
      final date = DateTime.parse(creationDate);
      return '${date.year}/${date.month}/${date.day} - ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return creationDate;
    }
  }
}

class CreateReservationRequest {
  final int cafeResturantId;
  final int customerCount;
  final String request;
  final String reserveDate;

  CreateReservationRequest({
    required this.cafeResturantId,
    required this.customerCount,
    required this.request,
    required this.reserveDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'cafeResturantId': cafeResturantId,
      'customerCount': customerCount,
      'request': request,
      'reserveDate': reserveDate,
    };
  }
}

class UpdateReservationRequest {
  final int id;
  final String answer;
  final int statusId;

  UpdateReservationRequest({
    required this.id,
    required this.answer,
    required this.statusId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'answer': answer,
      'statusId': statusId,
    };
  }
}