part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}
final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final ArticlesModel data;
  SearchSuccess(this.data);
}

final class SearchFailure extends SearchState {
  final String message;
  SearchFailure(this.message);
}
