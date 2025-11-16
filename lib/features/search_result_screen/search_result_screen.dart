import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/styles/app_text_styles.dart';
import 'package:news_app/core/widgets/spacing_widgets.dart';
import 'package:news_app/features/home_screen/models/top_headlines_model.dart';
import 'package:news_app/features/home_screen/widgets/article_card_widget.dart';
import 'package:intl/intl.dart';
import 'searvices/search_result_services.dart';

class searchResultScreen extends StatelessWidget {
  const searchResultScreen({super.key, required this.query});
final String query;
const searchResultScreen.query(this.query);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Search Results', style: AppTextStyles.black14SemiBold,),
        centerTitle: true,
      ),
      body: FutureBuilder<ArticlesModel?>(
        future: SearchResultServices().SearchItemByName(query),
        builder: (context, AsyncSnapshot<ArticlesModel?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final data = snapshot.data;
          if (data == null) {
            return const Center(child: Text('No Data'));
          }
          if ((data.totalResults ?? 0) == 0 || (data.articles?.isEmpty ?? true)) {
            return Center(
              child: Text(
                'no results',
                style: TextStyle(
                  fontSize: 25.sp,
                  color: Colors.black,
                ),
              ).tr(),
            );
          }
          return Column(
            children: [
              const HeightSpace(24),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0),
                          child: ListView.builder(
                            itemCount: data.articles!.length,
                            itemBuilder: (context, index) {
                              return ArticleCardWidget(
                                title: data.articles![index].title ?? "",
                                authorName: data.articles![index].author ?? "",
                                date: DateFormat('MMMM d, y').format(data.articles![index].publishedAt!),
                                imageUrl: data.articles![index].urlToImage,
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
