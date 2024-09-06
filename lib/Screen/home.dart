import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_model/model/post_model.dart';
import 'package:flutter_model/services/remort_services.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> postList = [];
  bool isLoading = false;

  @override
  void initState() {
    getPost();
    // TODO: implement initState
    super.initState();
  }

  getPost() async {
    setState(() {
      isLoading = true;
    });
    var res = await RemoteService().getPost();
    postList = res;

    setState(() {
      isLoading = false;
    });

    // var re = Post.fromJson(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (context, index) => Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(postList[index].id.toString()),
                    Text(postList[index].body.toString()),
                    Text(postList[index].title.toString()),
                  ],
                ),
              ),
            ),
    );
  }
}
