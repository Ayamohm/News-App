import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/styles/app_text_styles.dart';
import 'package:news_app/core/widgets/spacing_widgets.dart';
import 'package:news_app/features/home_screen/models/top_headlines_model.dart';
import 'package:news_app/features/home_screen/widgets/article_card_widget.dart';
import 'package:intl/intl.dart';
import 'searvices/search_result_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_bloc/search_bloc.dart';

class searchResultScreen extends StatelessWidget {
  const searchResultScreen({super.key, required this.query});
final String query;
const searchResultScreen.query(this.query);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Search Results', style: AppTextStyles.black14SemiBold,),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            tooltip: 'Clear',
            onPressed: () {
              context.read<SearchBloc>().add(ClearSearchEvent());
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body:BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state){
          if(state is SearchLoading){
            return const Center(child: CircularProgressIndicator());
          }
          if(state is SearchFailure){
            return Center(child: Text(state.message));
          }
          if(state is SearchSuccess){
            final data=state.data;
            if(data.totalResults!=0){
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
            }
          }
          return const Center(child: Text('No results found'));
        },
      ),
      )
    );
  }
}
