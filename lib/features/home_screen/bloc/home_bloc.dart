import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/home_screen/models/top_headlines_model.dart';

import '../services/home_screen_services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetTopheadLinesEvent>(getTopHeadlines) ;
  }
  Future<void> getTopHeadlines(
      GetTopheadLinesEvent event, Emitter<HomeState> emit) async {

    emit(HomeLoading());

    try {
      //get data from api
      final data = await HomeScreenServices().getTopHeadLineApi();
      //if it success then get the data
      emit(HomeSuccess(data!));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}

