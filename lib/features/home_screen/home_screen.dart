import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/routing/app_routes.dart';
import 'package:news_app/core/styles/app_text_styles.dart';
import 'package:news_app/core/widgets/spacing_widgets.dart';
import 'package:news_app/features/home_screen/models/top_headlines_model.dart';
import 'package:news_app/features/home_screen/services/home_screen_services.dart';
import 'package:news_app/features/home_screen/widgets/article_card_widget.dart';
import 'package:news_app/features/home_screen/widgets/custom_category_item_widget.dart';
import 'package:news_app/features/home_screen/widgets/search_text_field_widget.dart';
import 'package:news_app/features/home_screen/widgets/top_headline_item_widget.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }
DateTime time=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xffE9EEFA),
            toolbarHeight: 120.h,
            title: Text("explore".tr(), style: AppTextStyles.titlesStyles),
            actions: [
              SearchTextFieldWidget()
            ]),
        body: FutureBuilder(
          future: HomeScreenServices().getTopHeadLineApi(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()));
            }
            if(snapshot.hasData){
              ArticlesModel topHeadlinesModel =snapshot.data!;
              if(topHeadlinesModel.totalResults==0){
                return Center(child: Text('no results',style: TextStyle(
                  fontSize: 25.sp,
                  color: Colors.black,
                ),).tr());
              }
              print(snapshot.data);
              return Column(
                children: [
                  const HeightSpace(16),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 32.w),
                    child: SizedBox(
                      height: 40.h,
                      child:
                      ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          CustomCategoryItemWidget(title: 'travel'.tr(), onTap: () { 
                            GoRouter.of(context).pushNamed(AppRoutes.searchResultScreen,extra: 'travel');
                          },),
                          CustomCategoryItemWidget(title: 'sports'.tr(), onTap: () {
                            GoRouter.of(context).pushNamed(AppRoutes.searchResultScreen,extra: 'sports');
                          },),
                          CustomCategoryItemWidget(title: 'entertainment'.tr(), onTap: () {
                            GoRouter.of(context).pushNamed(AppRoutes.searchResultScreen,extra: 'entertainment');
                          },),
                          CustomCategoryItemWidget(title: 'technology'.tr(), onTap: () {
                            GoRouter.of(context).pushNamed(AppRoutes.searchResultScreen,extra: 'technology');
                          },),
                          CustomCategoryItemWidget(title: 'health'.tr(), onTap: () {
                            GoRouter.of(context).pushNamed(AppRoutes.searchResultScreen,extra: 'health');
                          },),
                          CustomCategoryItemWidget(title: 'science'.tr(), onTap: () {
                            GoRouter.of(context).pushNamed(AppRoutes.searchResultScreen,extra: 'science');
                          },),
                          CustomCategoryItemWidget(title: 'business'.tr(), onTap: () {
                            GoRouter.of(context).pushNamed(AppRoutes.searchResultScreen,extra: 'business');
                          },),
                        ],
                      ),
                    ),
                  ),
                  const HeightSpace(24),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Column(
                        children: [
                          TopHeadlineItemWidget(
                            title: topHeadlinesModel.articles![0].title??"",
                            authorName: topHeadlinesModel.articles![0].author??"",
                            date: DateFormat('MMMM d, y').format(topHeadlinesModel.articles![0].publishedAt!),
                            imageUrl: topHeadlinesModel.articles![0].urlToImage,
                          ),
                          const HeightSpace(24),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7.0),
                              child: ListView.builder(
                                  itemCount: topHeadlinesModel.articles!.length,
                                  itemBuilder: (context, index) {
                                    return ArticleCardWidget(
                                      title: topHeadlinesModel.articles![index].title??"",
                                      authorName: topHeadlinesModel.articles![index].author??"",
                                      date: DateFormat('MMMM d, y').format(topHeadlinesModel.articles![index].publishedAt!),
                                      imageUrl: topHeadlinesModel.articles![index].urlToImage,
                                    );
                                  }
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
            return const Center(child: Text('No Data'));

          }
        )
    );
  }
}
