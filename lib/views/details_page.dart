import 'package:bloc_task/bloc/details%20bloc/details_bloc.dart';
import 'package:bloc_task/bloc/lyrics%20bloc/lyrics_bloc.dart';
import 'package:bloc_task/database/database.dart';
import 'package:bloc_task/resources/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/details_model.dart';
import 'components/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required this.trackId,
  }) : super(key: key);
  final String trackId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DetailsBloc(
              RepositoryProvider.of<ApiRepository>(context), trackId)
            ..add(GetTrackDetails()),
        ),
        BlocProvider(
          create: (context) =>
              LyricsBloc(RepositoryProvider.of<ApiRepository>(context), trackId)
                ..add(GetLyricsList()),
        ),
      ],
      child: Scaffold(
        appBar: buildAppBar('Track Details', false),
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<DetailsBloc, DetailsState>(
              builder: (context, state) {
                if (state is DetailsInitial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is DetailsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is DetailsLoaded) {
                  final details = state.details;
                  return Stack(
                    children: [
                      Positioned(
                        right: 10,
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            size: 40,
                            color: Colors.red[700],
                          ),
                          onPressed: () {
                            DBProvider.db.newTrack(details);
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          trackDetail('Name', details.trackName),
                          trackDetail('Artist', details.artistName),
                          trackDetail('Album Name', details.albumName),
                          trackDetail('Explicit',
                              details.explicit == 0 ? 'False' : 'True'),
                          trackDetail('Rating', details.trackRating.toString()),
                        ],
                      )
                    ],
                  );
                } else if (state is DetailsError) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            BlocBuilder<LyricsBloc, LyricsState>(
              builder: (context, state) {
                if (state is LyricsInitial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LyricsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LyricsLoaded) {
                  final lyrics = state.lyrics;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Lyrics',
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 17),
                        ),
                        Text(
                          lyrics.lyricsBody,
                          style: const TextStyle(fontSize: 26),
                        ),
                      ],
                    ),
                  );
                } else if (state is LyricsError) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
