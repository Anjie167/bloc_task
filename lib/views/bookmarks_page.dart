import 'package:bloc_task/database/database.dart';
import 'package:bloc_task/views/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/details_model.dart';
import '../resources/api_repository.dart';
import 'details_page.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Track> trackList = [];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            DBProvider.db.deleteAll();

          });
        },
        child: const Icon(Icons.delete),
      ),
      appBar: buildAppBar('Bookmarks', false),
      body: FutureBuilder<List<Track>>(
        future: DBProvider.db.getAllTrack(),
        builder: (context, AsyncSnapshot<List<Track>> snapshot) {
          if (snapshot.hasData) {
            trackList = snapshot.data!;
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No Bookmarks'),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 30),
                shrinkWrap: true,
                itemCount: trackList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RepositoryProvider(
                            create: (BuildContext context) => ApiRepository(),
                            child: DetailsScreen(trackId: trackList[index].trackId.toString(),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.05,),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: Text(trackList[index].trackName,
                            style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  );
                }, separatorBuilder: (BuildContext context, int index) { return const Divider(); },);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
