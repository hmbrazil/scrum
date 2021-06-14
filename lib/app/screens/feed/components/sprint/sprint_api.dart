import 'dart:convert';
import 'package:http/http.dart';
import 'package:social/app_module.dart';
import 'package:social/app/shared/models/sprint.dart';
import 'package:social/app/shared/util/constants.dart';

class SprintApi {

  final _client = AppModule.to.getDependency<Client>();

  Future<List<Sprint>> fetchListAll() async {
    final response = await _client.get(Uri.parse('${Constants.API_BASE_URL}/sprint'));

    if (response.statusCode == 200) {
      final List<dynamic> jPosts = json.decode(response.body);
      final sprint = jPosts.map((jp) => Sprint.fromJson(jp)).toList();

      return sprint;
    }
    else {
      throw Exception('Erro ao recuperar recuperar lista. Status Code: ${response.statusCode}');
    }
  }

  Future<Sprint> fetchDetail(int id) async {
    final response = await _client.get(Uri.parse('${Constants.API_BASE_URL_DETALHE}/$id'));

    if (response.statusCode == 200) {
      return Sprint.fromRawJson(response.body);
    }
    else {
      throw Exception('Erro ao recuperar registro. Status Code: ${response.statusCode}');
    }
  }

  Future<Sprint> fetchDelete(int id) async {

    final response = await _client.delete(Uri.parse('${Constants.API_BASE_URL_DELETE}/$id'));

    if (response.statusCode == 200) {
      return Sprint.fromRawJson(response.body);
    }
    else {
      throw Exception('Erro ao remover registro. Status Code: ${response.statusCode}');
    }
  }

  Future<Sprint> fetchCreate(Sprint sprint) async {

    Map data = {
      'nome': sprint.nome,
      'link': sprint.link
    };

    final response = await post(
      Uri.parse('${Constants.API_BASE_URL_ADICIONA}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return Sprint.fromRawJson(response.body);
    }
    else {
      throw Exception('Falha ao criar registro. Status Code: ${response.statusCode}');
    }
  }
}