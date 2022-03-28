part of 'track_bloc.dart';


abstract class TracksEvent extends Equatable{
  const TracksEvent();


}
class GetTrackList extends TracksEvent{

  @override
  List<Object> get props => [];
}