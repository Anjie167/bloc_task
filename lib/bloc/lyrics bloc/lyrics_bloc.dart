import 'package:bloc/bloc.dart';
import 'package:bloc_task/models/lyrics_model.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_task/resources/api_repository.dart';

part 'lyrics_bloc_events.dart';
part 'lyrics_bloc_state.dart';
class LyricsBloc extends Bloc<LyricsEvent, LyricsState> {

  final ApiRepository _apiRepository;
  LyricsBloc(this._apiRepository, String trackID) : super(LyricsLoading()) {
    on<GetLyricsList>((event, emit) async {
      emit(LyricsLoading());
      try {
        Lyrics lyrics = await _apiRepository.getLyrics(trackID);
        emit(LyricsLoaded(lyrics: lyrics));
      } catch (e){
        emit(LyricsError(message: e.toString()));
      }
    });
  }
}
