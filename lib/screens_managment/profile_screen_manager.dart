import 'package:coffechi2/models/profile_model.dart';
import 'package:coffechi2/services/api_service.dart';
import 'package:coffechi2/services/auth_service.dart';
import 'package:coffechi2/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../models/cafe_type.dart';
import 'edit_profile_screen.dart';
import 'cafe_comments_page.dart';

class ProfileScreenManager extends StatefulWidget {
  const ProfileScreenManager({super.key});

  @override
  State<ProfileScreenManager> createState() => _ProfileScreenManagerState();
}

class _ProfileScreenManagerState extends State<ProfileScreenManager> {
  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();
  bool _isLoading = true;
  String? _errorMessage;
  ManagerProfile? _profile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final profile = await _apiService.getManagerProfile();
      setState(() {
        _profile = profile;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshProfile() async {
    await _loadProfile();
  }

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('خروج از حساب'),
          content: const Text('آیا از خروج خود مطمئن هستید؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('لغو'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text('خروج', style: TextStyle(color: AppColors.white)),
            ),
          ],
        ),
      ),
    );

    if (confirm == true) {
      await _authService.logout();
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/LoginScreen');
    }
  }

  String _getCategoryNames(List<CafeType> typeList) {
    if (typeList.isEmpty) return 'ثبت نشده';
    return typeList.map((e) => e.name).join('، ');
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.black10,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: AppColors.tertiary,
          title: const Text(
            'پروفایل مجموعه',
            style: TextStyle(color: AppColors.secondary),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshProfile,
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('در حال بارگذاری...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text('تلاش مجدد', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }

    if (_profile == null) {
      return const Center(
        child: Text('اطلاعاتی یافت نشد'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 58,
                    backgroundImage: AssetImage('assets/images/restaurant_1.jpg'),
                    child: Icon(Icons.restaurant, size: 50),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  _profile!.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _profile!.phoneNumber,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildOutlinedButton(
                  textName: 'مدیریت منو',
                  onPressed: () {
                    Navigator.pushNamed(context, '/MenuManagementScreen');
                  },
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: _buildOutlinedButton(
                  textName: 'نظرات کافه',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CafeCommentsPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: _buildElevatedButton(
                  textName: 'ویرایش اطلاعات',
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditProfilePageManager(
                          profile: _profile!,
                        ),
                      ),
                    );
                    if (result == true) {
                      _loadProfile();
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoCard(
            icon: Icons.location_on,
            title: 'آدرس',
            subtitle: _profile!.address ?? 'ثبت نشده',
          ),
          const SizedBox(height: 15),
          _buildInfoCard(
            icon: Icons.access_time,
            title: 'ساعات کاری',
            subtitle: _profile!.workTime ?? 'ثبت نشده',
          ),
          const SizedBox(height: 15),
          _buildInfoCard(
            icon: Icons.category,
            title: 'دسته‌بندی',
            subtitle: _getCategoryNames(_profile!.typeList),
          ),
          const SizedBox(height: 20),

          /// دکمه خروج (Logout)
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildElevatedButton({
    required String textName,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 4,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
      child: Text(textName),
    );
  }

  Widget _buildOutlinedButton({
    required String textName,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        side: BorderSide(color: AppColors.primary, width: 2),
        foregroundColor: AppColors.primary,
        elevation: 4,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
      child: Text(
        textName,
        style: TextStyle(color: AppColors.primary),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: _logout,
        icon: const Icon(Icons.logout, size: 20, color: Colors.red),
        label: const Text(
          'خروج از حساب',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.red,
          ),
        ),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: const BorderSide(color: Colors.red, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.tertiary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}