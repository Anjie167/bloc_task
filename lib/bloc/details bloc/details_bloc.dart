import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_task/resources/api_repository.dart';
import 'package:bloc_task/models/details_model.dart' ;

part 'details_bloc_events.dart';
part 'details_bloc_state.dart';
class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {

  final ApiRepository _apiRepository;
  final String trackID;

  DetailsBloc(this._apiRepository, this.trackID) : super(DetailsLoading()) {
    on<GetTrackDetails>((event, emit) async {
      emit(DetailsLoading());
      try {
        Track details = await _apiRepository.getDetails(trackID);
        emit(DetailsLoaded(details: details));
      } catch (e){
        emit(DetailsError(message: e.toString()));
      }
    });
  }
}
