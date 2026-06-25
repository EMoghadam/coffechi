import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_theme.dart';
Widget getCustomBotton({required textName, required function}) {
  return SizedBox(
    width: 155,
    child: ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // شعاع گردی گوشه‌ها
        ),
        backgroundColor: AppColors.white,
        // رنگ پس‌زمینه دکمه
        foregroundColor: AppColors.primary,
        // رنگ متن/آیکن دکمه
        elevation: 4,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        textStyle: AppTextTheme.textTheme.bodyLarge,
      ),
      child: Text(
        textName,
        style:AppTextTheme.textTheme.bodyLarge,
      ),
    ),
  );
}

Widget getPaddingMethods({required Widget child}) {
  return Padding(
    padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    child: Container(
      child: child,
    ),
  );
}
