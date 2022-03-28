part of 'lyrics_bloc.dart';

abstract class LyricsState extends Equatable{}

class LyricsInitial extends LyricsState{
  @override
  List<Object?> get props => [];
}

class LyricsLoading extends LyricsState{
  @override
  List<Object> get props => [];
}

class LyricsLoaded extends LyricsState{


  final Lyrics lyrics;
  LyricsLoaded({required this.lyrics});
  @override
  List<Object?> get props => [lyrics];
}

class LyricsError extends LyricsState{
  final String message;
  LyricsError({required this.message});
  @override
  List<Object> get props => [message];
}
