part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}
class SearchNewsEvent extends SearchEvent{
  final String query;
  SearchNewsEvent(this.query);
}

class ClearSearchEvent extends SearchEvent {}
