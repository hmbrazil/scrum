import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social/app_module.dart';
import 'package:social/app/shared/models/sprint.dart';
import 'package:social/app/shared/util/constants.dart';

class FeedApiDetalhe {

  final _client = AppModule.to.getDependency<Client>();

  Future<Sprint> fetchPosts(int id) async {
    final response = await _client.get(Uri.parse('${Constants.API_BASE_URL}/sprint/$id'));

    if (response.statusCode == 200) {
      return Sprint.fromRawJson(response.body);
    }
    else {
      throw Exception('Erro ao recuperar posts. Status Code: ${response.statusCode}');
    }
  }
}
