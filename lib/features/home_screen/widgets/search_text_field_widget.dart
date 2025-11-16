import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/widgets/custom_text_field.dart';

import '../../../core/routing/app_routes.dart';

class SearchTextFieldWidget extends StatefulWidget {
  const SearchTextFieldWidget({super.key});

  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isSearch ? CustomTextField(
          onFieldSubmitted: (value){
            GoRouter.of(context).pushNamed(AppRoutes.searchResultScreen,extra: value);
          },
          width: 200.w,
          hintText: 'search'.tr(),
        ):SizedBox.shrink(),
        IconButton(
            onPressed: () {
              setState(() {
                isSearch = !isSearch;
              });
            },
            icon: const Icon(
              Icons.search,
              color: Color(0xff231F20),
            )),
      ]

    );
  }
}
