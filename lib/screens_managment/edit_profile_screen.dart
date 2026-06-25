import 'package:coffechi2/models/cafe_type.dart';
import 'package:coffechi2/models/profile_model.dart';
import 'package:coffechi2/services/api_service.dart';
import 'package:coffechi2/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EditProfilePageManager extends StatefulWidget {
  final ManagerProfile profile;

  const EditProfilePageManager({super.key, required this.profile});

  @override
  State<EditProfilePageManager> createState() => _EditProfilePageManagerState();
}

class _EditProfilePageManagerState extends State<EditProfilePageManager> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _hoursController;

  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  bool _isLoadingTypes = true;

  List<CafeType> _cafeTypes = [];
  List<int> _selectedTypeIds = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _addressController = TextEditingController(
      text: widget.profile.address ?? '',
    );
    _phoneController = TextEditingController(text: widget.profile.phoneNumber);
    _hoursController = TextEditingController(
      text: widget.profile.workTime ?? '',
    );

    // ذخیره typeIdهای فعلی
    _selectedTypeIds = widget.profile.typeList.map((e) => e.id).toList();

    _loadCafeTypes();
  }

  Future<void> _loadCafeTypes() async {
    setState(() => _isLoadingTypes = true);
    try {
      final types = await _apiService.getCafeTypes();
      setState(() {
        _cafeTypes = types;
        _isLoadingTypes = false;
      });
    } catch (e) {
      setState(() => _isLoadingTypes = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              'خطا در دریافت دسته‌بندی‌ها: ${e.toString().replaceFirst('Exception: ', '')}',
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _hoursController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedTypeIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text('لطفاً حداقل یک دسته‌بندی انتخاب کنید'),
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final request = UpdateProfileRequest(
        name: _nameController.text,
        address: _addressController.text,
        phoneNumber: _phoneController.text,
        workTime: _hoursController.text,
        typeList: _selectedTypeIds, // ارسال لیست idهای انتخاب شده
      );

      await _apiService.updateManagerProfile(request);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text('پروفایل با موفقیت به‌روزرسانی شد'),
          ),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(e.toString().replaceFirst('Exception: ', '')),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'ویرایش پروفایل',
          style: TextStyle(color: AppColors.secondary),
        ),
        centerTitle: true,
        backgroundColor: AppColors.tertiary,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveProfile,
            child: const Text(
              'ذخیره',
              style: TextStyle(
                color: AppColors.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  controller: _nameController,
                  label: 'نام کافه/رستوران',
                  icon: Icons.restaurant_menu,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'نام کافه الزامی است';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _addressController,
                  label: 'آدرس کامل',
                  icon: Icons.location_on,
                  maxLines: 2,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _phoneController,
                  label: 'شماره تلفن',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'شماره تلفن الزامی است';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _hoursController,
                  label: 'ساعات کاری (مثال: 09:00-23:00)',
                  icon: Icons.access_time,
                ),
                const SizedBox(height: 20),

                // بخش دسته‌بندی‌ها (نوع کافه/رستوران)
                const Text(
                  'دسته‌بندی مجموعه',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'نوع کافه/رستوران خود را انتخاب کنید',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 12),

                _buildCategoriesSection(),

                const SizedBox(height: 30),

                if (_isLoading)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    if (_isLoadingTypes) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_cafeTypes.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'دسته‌بندی‌ای یافت نشد',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 10,
        children: _cafeTypes.map((type) {
          final isSelected = _selectedTypeIds.contains(type.id);
          return FilterChip(
            label: Text(type.name),
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  _selectedTypeIds.add(type.id);
                } else {
                  _selectedTypeIds.remove(type.id);
                }
              });
            },
            backgroundColor: Colors.grey[100],
            selectedColor: AppColors.tertiary,
            checkmarkColor: AppColors.primary,
            labelStyle: TextStyle(
              color: isSelected ? AppColors.primary : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected ? AppColors.primary : Colors.grey[300]!,
                width: 1,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.black6, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2.0),
        ),
      ),
    );
  }
}
