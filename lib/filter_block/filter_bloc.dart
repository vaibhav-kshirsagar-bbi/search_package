part of search_package;



class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitial()) {
    on<FilterEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ReloadEvent>((event, emit) {
      emit(ReloadState());
    });

  }

  reloadEvent(){

    add(ReloadEvent());

  }

}
