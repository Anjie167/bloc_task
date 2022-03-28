part of 'track_bloc.dart';

abstract class TrackState extends Equatable{}

class TrackInitial extends TrackState{
  @override
  List<Object?> get props => [];
}

class TrackLoading extends TrackState{
  @override
  List<Object> get props => [];
}

class TrackLoaded extends TrackState{


  final List<TrackList> trackList;
  TrackLoaded({required this.trackList});
  @override
  List<Object?> get props => [trackList];
}

class TrackError extends TrackState{
  final String message;
  TrackError({required this.message});
  @override
  List<Object> get props => [message];
}
