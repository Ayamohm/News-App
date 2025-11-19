import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/routing/app_routes.dart';
import 'package:news_app/core/styles/app_text_styles.dart';
import 'package:news_app/core/widgets/spacing_widgets.dart';
import 'package:news_app/features/home_screen/bloc/home_bloc.dart';
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
    return BlocProvider(
      create: (context) => HomeBloc()..add(GetTopheadLinesEvent()),
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: const Color(0xffE9EEFA),
              toolbarHeight: 120.h,
              title: Text("explore".tr(), style: AppTextStyles.titlesStyles),
              actions: [
                SearchTextFieldWidget()
              ]),
          body: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state){
                if(state is HomeLoading){
                  return const Center(child: CircularProgressIndicator());
                }
                if(state is HomeError){
                  return Center(child: Text(state.message));
                }
                if(state is HomeSuccess){
                  final topHeadlinesModel =state.data;
                  if(topHeadlinesModel.articles == null || topHeadlinesModel.articles!.isEmpty){
                    return Center(
                      child: Text(
                        'no results',
                        style: TextStyle(fontSize: 25.sp, color: Colors.black),
                      ).tr(),
                    );
                  }
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
                                date: topHeadlinesModel.articles![0].publishedAt !=null?DateFormat('MMMM d, y').format(topHeadlinesModel.articles!.first.publishedAt!):"",
                                imageUrl: topHeadlinesModel.articles![0].urlToImage ??"",
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
                                          date: topHeadlinesModel.articles![index].publishedAt!=null?DateFormat('MMMM d, y').format(topHeadlinesModel.articles![index].publishedAt!):"",
                                          imageUrl: topHeadlinesModel.articles![index].urlToImage??"",
                                          onTap: () {
                                            GoRouter.of(context).pushNamed(AppRoutes.articleDetailsScreen,extra: topHeadlinesModel.articles![index]);
                                          },
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

                return const SizedBox.shrink();
              }
          )
      )

    );
  }
}
