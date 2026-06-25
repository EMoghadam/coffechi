import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _roleKey = 'user_role';
  static const String _isCustomerKey = 'is_customer';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, role);
    await prefs.setBool(_isCustomerKey, role == 'customer');
  }

  Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey);
  }

  Future<void> saveIsCustomer(bool isCustomer) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isCustomerKey, isCustomer);
    await prefs.setString(_roleKey, isCustomer ? 'customer' : 'manager');
  }

  Future<bool?> getIsCustomer() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isCustomerKey);
  }

  Future<bool> isCustomer() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isCustomerKey) ?? true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_roleKey);
    await prefs.remove(_isCustomerKey);
  }
}