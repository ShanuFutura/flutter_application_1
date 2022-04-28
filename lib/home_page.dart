import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/second_page.dart';
import 'package:http/http.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<dynamic> getUsers() async {
    final res = await get(Uri.parse('https://reqres.in/api/users?page=2'));
    print(jsonDecode(res.body)['data']);
    return jsonDecode(res.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getUsers(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snap.hasData) {
          return ListView.builder(
              itemCount: (snap.data as List).length,
              itemBuilder: (cotnext, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SecondPage(
                          (snap.data as dynamic)[index]['id'].toString());
                    }));
                  },
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage((snap.data as dynamic)[index]['avatar']),
                  ),
                  title: Text((snap.data as dynamic)[index]['first_name']),
                  subtitle: Text((snap.data as dynamic)[index]['last_name']),
                );
              });
        } else {
          return Text('No data');
        }
      },
    ));
  }
}
