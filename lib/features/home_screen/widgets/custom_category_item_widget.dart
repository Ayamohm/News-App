import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/styles/app_text_styles.dart';

class CustomCategoryItemWidget extends StatelessWidget {
  final String title;
  final Function() onTap;
  const CustomCategoryItemWidget({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: TextButton(
        onPressed: () {
          onTap();
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
          backgroundColor: Colors.transparent,
          side: const BorderSide(color: Color(0xffE9EEFA), width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(56.r),
          ),
          ),
          child: Text(
            title,
            style: AppTextStyles.black14SemiBold,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
