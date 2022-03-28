import 'package:bloc_task/models/track_list_model.dart';
import 'package:bloc_task/resources/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../details_page.dart';

class TrackTile extends StatelessWidget {
  const TrackTile({
    Key? key,
    required this.trackList,
  }) : super(key: key);

  final TrackList trackList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RepositoryProvider(
              create: (BuildContext context) => ApiRepository(),
              child: DetailsScreen(trackId: trackList.track.trackId.toString(),
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Icon(
                Icons.library_music,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              width: size.width * 0.05,
            ),
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(trackList.track.trackName),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(trackList.track.albumName),
                ],
              ),
            ),
            // const Spacer(),
            Expanded(
              flex: 2,
              child: SizedBox(
                width: size.width * 0.3,
                child: Text(
                  trackList.track.artistName,
                  maxLines: 2,
                ),
              ),
            ),
            // SizedBox(
            //   width: size.width * 0.05,
            // )
          ],
        ),
      ),
    );
  }
}
