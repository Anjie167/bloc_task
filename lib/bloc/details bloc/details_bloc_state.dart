part of 'details_bloc.dart';

abstract class DetailsState extends Equatable{}

class DetailsInitial extends DetailsState{
  @override
  List<Object?> get props => [];
}

class DetailsLoading extends DetailsState{
  @override
  List<Object> get props => [];
}

class DetailsLoaded extends DetailsState{


  final Track details;
  DetailsLoaded({required this.details});
  @override
  List<Object?> get props => [details];
}

class DetailsError extends DetailsState{
  final String message;
  DetailsError({required this.message});
  @override
  List<Object> get props => [message];
}

