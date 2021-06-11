import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social/app_module.dart';
import 'package:social/app/shared/models/sprint.dart';
import 'package:social/app/shared/util/constants.dart';

class FeedApi {

  final _client = AppModule.to.getDependency<Client>();

  Future<List<Sprint>> fetchPosts() async {
    final response = await _client.get(Uri.parse('${Constants.API_BASE_URL}/sprint'));

    if (response.statusCode == 200) {
      final List<dynamic> jPosts = json.decode(response.body);
      final sprint = jPosts.map((jp) => Sprint.fromJson(jp)).toList();
      // for (final p in posts) {
      //   final res = await _client.get(Uri.parse('${Constants.API_BASE_URL}/users/${p.userId}'));
      //   res.statusCode == 200 ? p.user = User.fromRawJson(res.body) : p.user = null;
      // }
      return sprint;
    }
    else {
      throw Exception('Erro ao recuperar posts. Status Code: ${response.statusCode}');
    }
  }
}