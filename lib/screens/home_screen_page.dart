import 'package:check_connectivity_bloc/bloc/internet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreenPage'),
        centerTitle: true,
      ),
      //Below if we want to show change in screen widget build then we can also use BlocProvider 
      //Here, we only want to show the toast that's why we used BlocListener.
      //if you want to show both then we can can implement Bloc Consumer
      body: BlocListener<InternetBloc, InternetState>(
        listener: (context, state) {
          if (state is InternetGainedState) {
            Fluttertoast.showToast(msg: "Internet Connected");
          } else if (state is InternetLostState) {
            Fluttertoast.showToast(msg: "Internet Disconnected");
          }
        },
        child: const Center(
          child: Text(
            'HomeScreenPage is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
