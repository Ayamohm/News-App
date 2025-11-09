
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/features/home_screen/services/home_screen_services.dart';
import 'package:news/features/home_screen/widgets/article_card_widget.dart';
import 'package:news/features/home_screen/widgets/custom_category_item_widget.dart';
import 'package:news/features/home_screen/widgets/top_headline_item_widget.dart';

import '../../core/styles/app_text_styles.dart';
import '../../core/widgets/spacing_widgets.dart';
import 'models/top_headlines_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xffE9EEFA),
            toolbarHeight: 120.h,
            title: Text("explore".tr(), style: AppTextStyles.titlesStyles),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Color(0xff231F20),
                  )),
            ]),
        body: FutureBuilder(
            future: HomeScreenServices().getTopHeadlineArticle(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }

              if (snapshot.hasData) {
                TopHeadLinesModel topHeadLinesModel =
                    snapshot.data! as TopHeadLinesModel;
                if (topHeadLinesModel.totalResults == 0) {
                  return Center(
                    child: Text("no_results".tr()),
                  );
                }
                return Column(
                  children: [
                    const HeightSpace(16),
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 32.w),
                      child: SizedBox(
                        height: 40.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            CustomCategoryItemWidget(title: "travel".tr()),
                            CustomCategoryItemWidget(title: "technology".tr()),
                            CustomCategoryItemWidget(title: "business".tr()),
                            CustomCategoryItemWidget(
                                title: "entertainment".tr()),
                          ],
                        ),
                      ),
                    ),
                    const HeightSpace(24),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Column(
                        children: [
                          TopHeadlineItemWidget(
                            imageUrl: topHeadLinesModel.articles![0].urlToImage,
                            // imageUrl:
                            //     "https://www.cnet.com/a/img/resize/bde1b8ca1b9373b61bbf9d3e113a81ac76297b51/hub/2024/09/13/0df30744-a33f-4c6e-b58c-a90d7a914089/apple-iphone-16-2815.jpg?auto=webp&height=500",
                            title: topHeadLinesModel.articles![0].title ?? "",
                            authorName:
                                topHeadLinesModel.articles![0].author ?? "",
                            date: DateFormat('yyyy-MM-dd – kk:mm').format(
                                topHeadLinesModel.articles![0].publishedAt!),
                          ),
                        ],
                      ),
                    ),
                    const HeightSpace(24),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: ListView.builder(
                          itemCount: topHeadLinesModel.articles!.length,
                          itemBuilder: (context, index) {
                            Article article =
                                topHeadLinesModel.articles![index];
                            return ArticleCardWidget(
                              title: article.title ?? "",
                              authorName: article.author ?? "",
                              date: DateFormat('yyyy-MM-dd – kk:mm')
                                  .format(article.publishedAt!),
                              imageUrl: article.urlToImage,
                            );
                          }),
                    ))
                  ],
                );
              }

              return Center(
                child: Text("Something went wrong"),
              );
            }));
  }
}
