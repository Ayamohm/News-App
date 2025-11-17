import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/home_screen/models/top_headlines_model.dart';
import 'package:news_app/features/search_result_screen/searvices/search_result_services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchNewsEvent>((event, emit) async {
      emit(SearchLoading());
      try{
        final ArticlesModel? data =await SearchResultServices().SearchItemByName(event.query);
        if(data!= null){
          emit(SearchSuccess(data));
        }else{
          emit(SearchFailure("No Data Found"));
        }
      }catch(e){
        emit(SearchFailure(e.toString()));
      }
    });
    on<ClearSearchEvent>((event, emit) {
      emit(SearchInitial());
    });
  }
}
