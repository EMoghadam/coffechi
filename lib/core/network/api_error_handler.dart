import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String handle(DioException e) {
    // Errors with response from server
    if (e.response != null) {
      switch (e.response!.statusCode) {
        case 400:
          return 'درخواست نامعتبر است';

        case 401:
          return 'نام کاربری یا رمز عبور اشتباه است';

        case 403:
          return 'شما دسترسی لازم را ندارید';

        case 404:
          return 'اطلاعات مورد نظر یافت نشد';

        case 409:
          return 'این نام کاربری قبلاً ثبت شده است';

        case 500:
          return 'خطای سرور، بعداً تلاش کنید';

        default:
          return 'خطا در ارتباط با سرور';
      }
    }

    // Dio specific errors
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'مهلت اتصال به سرور به پایان رسید';

      case DioExceptionType.sendTimeout:
        return 'ارسال درخواست بیش از حد طول کشید';

      case DioExceptionType.receiveTimeout:
        return 'پاسخی از سرور دریافت نشد';

      case DioExceptionType.connectionError:
        return 'اتصال اینترنت را بررسی کنید';

      case DioExceptionType.cancel:
        return 'درخواست لغو شد';

      case DioExceptionType.badCertificate:
        return 'گواهی امنیتی سرور معتبر نیست';

      case DioExceptionType.unknown:
        return 'اتصال اینترنت را بررسی کنید';

      default:
        return 'خطایی رخ داده است';
    }
  }
}