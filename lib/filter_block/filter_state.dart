part of search_package;

@immutable
abstract class FilterState {}

class FilterInitial extends FilterState {}
class ReloadState extends FilterState {}
