import 'package:bloc/bloc.dart';
import 'package:bloc_task/models/track_list_model.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_task/resources/api_repository.dart';

part 'track_bloc_events.dart';
part 'track_bloc_state.dart';
class TrackBloc extends Bloc<TracksEvent, TrackState> {

  final ApiRepository _apiRepository;
  TrackBloc(this._apiRepository) : super(TrackLoading()) {
    on<GetTrackList>((event, emit) async {
      emit(TrackLoading());
      try {
        List<TrackList> tracks = await _apiRepository.fetchTrackList();
        emit(TrackLoaded(trackList: tracks));
      } catch (e){
        emit(TrackError(message: e.toString()));
      }
    });
  }
}

