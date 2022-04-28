import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SecondPage extends StatelessWidget {
  const SecondPage(String this.id, {Key? key}) : super(key: key);
  final String id;
  Future<dynamic> getSingleUser() async {
    final res = await get(Uri.parse('https://reqres.in/api/users/$id'));
    return jsonDecode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: getSingleUser(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(80),
                    child: CircleAvatar(
                      radius: 90,
                      backgroundImage: NetworkImage(
                          (snap.data as dynamic)['data']['avatar']),
                    ),
                  ),
                  Text((snap.data as dynamic)['data']['first_name'])
                ]);
              }
            }),
      ),
    );
  }
}
