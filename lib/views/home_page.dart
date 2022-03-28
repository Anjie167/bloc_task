import 'dart:async';
import 'dart:io';

import 'package:bloc_task/bloc/track%20bloc/track_bloc.dart';
import 'package:bloc_task/resources/api_repository.dart';
import 'package:bloc_task/views/bookmarks_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/track_tile.dart';
import 'components/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  @override
  Widget build(BuildContext context) {
    String string;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
        string = 'Mobile: Online';
        break;
      case ConnectivityResult.wifi:
        string = 'WiFi: Online';
        break;
      case ConnectivityResult.none:
      default:
        string = 'No Internet';
    }
    return BlocProvider(
      create: (context) => TrackBloc(
        RepositoryProvider.of<ApiRepository>(context),
      )..add(GetTrackList()),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                const Bookmarks()
            ));
          },
          child: Column(
            children: const [
              Icon(Icons.bookmark),
              Text('Bookmarks',style: TextStyle(fontSize: 10),)
            ],
          ),
        ),
        appBar: buildAppBar('Trending', true),
        body: BlocBuilder<TrackBloc, TrackState>(
          builder: (context, state) {
            if (state is TrackInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TrackLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TrackLoaded) {
              final trackList = state.trackList;
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                shrinkWrap: true,
                itemCount: trackList.length,
                itemBuilder: (context, index) {
                  return TrackTile(trackList: trackList[index]);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              );
            } else if (state is TrackError) {
              return Center(
                child: Text(state.message),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }
}



class MyConnectivity {
  MyConnectivity._();

  static final _instance = MyConnectivity._();
  static MyConnectivity get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  void initialise() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _checkStatus(result);
    _connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}