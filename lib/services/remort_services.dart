import 'dart:convert';
import 'dart:developer';

import '../model/post_model.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  getPost() async {
    List<Post> postList = [];
    var client = http.Client();
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var ress = await client.get(uri);
    if (ress.statusCode == 200) {
      List res = jsonDecode(ress.body);

      res.map((data) => Post.fromJson(data)).toList();
   

   // loop add data to list model
      return res.map((data) {
        print(data);
        return Post.fromJson(data);
      }).toList();
    }
  }
}
