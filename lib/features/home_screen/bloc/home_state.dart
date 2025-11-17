part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

final class HomeInitial extends HomeState {}
class HomeLoading extends HomeState{}

//شايل الداتا الى جت من ال api
class HomeSuccess extends HomeState {
  final ArticlesModel data;
  HomeSuccess(this.data);

}


class HomeError extends HomeState{
  final String message;
  HomeError(this.message);
}
