import 'package:dio/dio.dart';
import '../dio_client.dart';
import '../models/auth_response.dart';
import '../models/cafe_type.dart';
import '../models/menu_model.dart';
import '../models/order_model.dart';
import '../models/profile_model.dart';
import '../models/reservation_model.dart';
import '../models/search_model.dart';

class ApiService {
  final Dio _dio = DioClient().dio;

  Future<AuthResponse> login({
    required String username,
    required String password,
    required bool isCustomer,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'username': username,
          'password': password,
          'isCustomer': isCustomer,
        },
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('نام کاربری یا رمز عبور اشتباه است');
      }
      throw Exception('خطا در ارتباط با سرور');
    }
  }

  Future<AuthResponse> register({
    required String username,
    required String password,
    required String name,
    required bool isCustomer,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: {
          'username': username,
          'password': password,
          'name': name,
          'isCustomer': isCustomer,
        },
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw Exception('این شماره موبایل قبلاً ثبت شده است');
      }
      throw Exception('خطا در ثبت‌نام');
    }
  }

  Future<List<CafeType>> getCafeTypes() async {
    try {
      final response = await _dio.get('/auth/crtypelist');
      final List<dynamic> data = response.data;
      return data.map((json) => CafeType.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('خطا در دریافت انواع کافه');
    }
  }

  Future<List<MenuCategory>> getMenus() async {
    try {
      final response = await _dio.get('/menu/withitem');
      final List<dynamic> data = response.data;
      return data.map((json) => MenuCategory.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('خطا در دریافت منوها');
      }
      throw Exception('خطا در ارتباط با سرور');
    }
  }

  Future<void> createMenu(String title) async {
    try {
      final request = CreateMenuRequest(title: title);
      await _dio.post('/menu/create', data: request.toJson());
    } on DioException catch (e) {
      throw Exception('خطا در ایجاد منو');
    }
  }

  Future<void> editMenu(int menuId, String title) async {
    try {
      final request = EditMenuRequest(menuId: menuId, title: title);
      await _dio.post('/menu/edit', data: request.toJson());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('منو پیدا نشد');
      }
      throw Exception('خطا در ویرایش منو');
    }
  }

  Future<void> deleteMenu(int menuId) async {
    try {
      final request = DeleteMenuRequest(menuId: menuId);
      await _dio.post('/menu/delete', data: request.toJson());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('منو پیدا نشد');
      }
      throw Exception('خطا در حذف منو');
    }
  }

  Future<void> createMenuItem(int menuId, String name, double amount) async {
    try {
      final request = CreateMenuItemRequest(
        menuId: menuId,
        name: name,
        amount: amount,
      );
      await _dio.post('/menu/item/create', data: request.toJson());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('منو پیدا نشد');
      }
      throw Exception('خطا در ایجاد آیتم');
    }
  }

  Future<void> editMenuItem(int menuItemId, String name, double amount) async {
    try {
      final request = EditMenuItemRequest(
        menuItemId: menuItemId,
        name: name,
        amount: amount,
      );
      await _dio.post('/menu/item/edit', data: request.toJson());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('آیتم پیدا نشد');
      }
      throw Exception('خطا در ویرایش آیتم');
    }
  }

  Future<void> deleteMenuItem(int menuItemId) async {
    try {
      final request = DeleteMenuItemRequest(menuItemId: menuItemId);
      await _dio.post('/menu/item/delete', data: request.toJson());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('آیتم پیدا نشد');
      }
      throw Exception('خطا در حذف آیتم');
    }
  }

  Future<ManagerProfile> getManagerProfile() async {
    try {
      final response = await _dio.get('/profile');
      return ManagerProfile.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('احراز هویت ناموفق');
      }
      throw Exception('خطا در دریافت اطلاعات پروفایل');
    }
  }

  Future<void> updateManagerProfile(UpdateProfileRequest request) async {
    try {
      await _dio.post('/profile', data: request.toJson());
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        throw Exception('خطا در ذخیره اطلاعات');
      }
      throw Exception('خطا در ارتباط با سرور');
    }
  }

  Future<List<Reservation>> getReservations() async {
    try {
      final response = await _dio.get('/reservation');
      final List<dynamic> data = response.data;
      return data.map((json) => Reservation.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('خطا در دریافت لیست رزروها');
      }
      if (e.response?.statusCode == 403) {
        throw Exception('دسترسی غیرمجاز');
      }
      throw Exception('خطا در ارتباط با سرور');
    }
  }

  Future<void> updateReservation({
    required int id,
    required String answer,
    required int statusId,
  }) async {
    try {
      final request = UpdateReservationRequest(
        id: id,
        answer: answer,
        statusId: statusId,
      );
      await _dio.post('/reservation/update', data: request.toJson());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('رزرو پیدا نشد یا وضعیت نامعتبر است');
      }
      throw Exception('خطا در بروزرسانی رزرو');
    }
  }

  Future<List<OrderResponse>> getMyOrders() async {
    try {
      final response = await _dio.get('/order/list');
      final List<dynamic> data = response.data;
      return data.map((json) => OrderResponse.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('خطا در دریافت سفارشات');
      }
      throw Exception('خطا در ارتباط با سرور');
    }
  }

  Future<OrderResponse> getOrderDetails(int orderId) async {
    try {
      final response = await _dio.get('/order/$orderId');
      return OrderResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('سفارش پیدا نشد');
      }
      throw Exception('خطا در دریافت جزئیات سفارش');
    }
  }

  Future<List<OrderListResponse>> getOrderList() async {
    try {
      final response = await _dio.get('/order/list');
      final List<dynamic> data = response.data;
      return data.map((json) => OrderListResponse.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('خطا در دریافت لیست سفارشات');
      }
      if (e.response?.statusCode == 401) {
        throw Exception('لطفاً دوباره وارد شوید');
      }
      throw Exception('خطا در ارتباط با سرور');
    }
  }

  Future<OrderListResponse> getOrderDetail(int orderId) async {
    try {
      final response = await _dio.get('/order/$orderId');
      return OrderListResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('سفارش پیدا نشد');
      }
      throw Exception('خطا در دریافت جزئیات سفارش');
    }
  }

  Future<void> createOrder(CreateOrderRequest request) async {
    try {
      await _dio.post('/order/new', data: request.toJson());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('خطا در ثبت سفارش');
      }
      throw Exception('خطا در ارتباط با سرور');
    }
  }

  Future<void> addComment(AddCommentRequest request) async {
    try {
      await _dio.post('/order/comment', data: request.toJson());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('خطا در ثبت نظر');
      }
      throw Exception('خطا در ارتباط با سرور');
    }
  }

  Future<void> updateOrderStatus({
    required int id,
    required int orderStatusId,
  }) async {
    try {
      await _dio.post('/order/update/status', data: {
        'id': id,
        'orderStatusId': orderStatusId,
      });
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('خطا در بروزرسانی وضعیت سفارش');
      }
      if (e.response?.statusCode == 403) {
        throw Exception('شما دسترسی به این عملیات را ندارید');
      }
      if (e.response?.statusCode == 401) {
        throw Exception('لطفاً دوباره وارد شوید');
      }
      throw Exception('خطا در ارتباط با سرور');
    }
  }

  Future<List<SearchRestaurant>> searchRestaurants(String query) async {
    try {
      final response = await _dio.get(
        '/search/caferesturant',
        queryParameters: {'name': query},
      );
      final List<dynamic> data = response.data;
      return data.map((json) => SearchRestaurant.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('خطا در جستجوی رستوران‌ها');
      }
      throw Exception('خطا در ارتباط با سرور');
    }
  }

  Future<List<SearchFood>> searchFoods(String query) async {
    try {
      final response = await _dio.get(
        '/search/food',
        queryParameters: {'name': query},
      );
      final List<dynamic> data = response.data;
      return data.map((json) => SearchFood.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('خطا در جستجوی غذاها');
      }
      throw Exception('خطا در ارتباط با سرور');
    }
  }

  Future<FoodDetailResponse> getFoodDetail(int foodId) async {
    try {
      final response = await _dio.get('/search/food/$foodId');
      return FoodDetailResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('غذا پیدا نشد');
      }
      throw Exception('خطا در دریافت جزییات غذا');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(int restaurantId) async {
    try {
      final response = await _dio.get('/search/caferesturant/$restaurantId');
      return RestaurantDetailResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('رستوران پیدا نشد');
      }
      throw Exception('خطا در دریافت جزییات رستوران');
    }
  }

  Future<void> createReservation({
    required int cafeResturantId,
    required int customerCount,
    required String request,
    required String reserveDate,
  }) async {
    try {
      await _dio.post('/reservation/new', data: {
        'cafeResturantId': cafeResturantId,
        'customerCount': customerCount,
        'request': request,
        'reserveDate': reserveDate,
      });
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('خطا در ثبت رزرو');
      }
      throw Exception('خطا در ارتباط با سرور');
    }
  }

  Future<List<dynamic>> getProfileComments() async {
    try {
      final response = await _dio.get('/profile/comments');
      final List<dynamic> data = response.data;
      return data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('خطا در دریافت نظرات');
      }
      throw Exception('خطا در ارتباط با سرور');
    }
  }
}