import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/post_model.dart';
import '../services/remort_services.dart';

class MyListView extends StatefulWidget {
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  late Future<List<Item>> futureItems;

  @override
  void initState() {
    futureItems = RemoteService().fetchItems();
    super.initState();
    // Fetch items when the widget is initialized
  }

  getData() async {
    futureItems = RemoteService().fetchItems();
    log(futureItems.toString());
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('API Data List'),
      ),
      body: FutureBuilder<List<Item>>(
        future: futureItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child:
                    CircularProgressIndicator()); // Show loading indicator while waiting
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No items found'));
          } else {
            // The data is loaded and available, display it in a ListView
            List<Item> items = snapshot.data!;

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index].name),
                  subtitle: Text('ID: ${items[index].id}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
