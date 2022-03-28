part of 'lyrics_bloc.dart';


abstract class LyricsEvent extends Equatable{
  const LyricsEvent();


}
class GetLyricsList extends LyricsEvent{

  @override
  List<Object> get props => [];
}