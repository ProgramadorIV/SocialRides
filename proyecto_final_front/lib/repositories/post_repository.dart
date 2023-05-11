import 'dart:convert';
import 'dart:ffi';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:proyecto_final_front/config/locator.dart';
import 'package:proyecto_final_front/model/models.dart';
import 'package:proyecto_final_front/rest/rest.dart';

@singleton
class PostRepository {
  late RestClient _client;
  late RestAuthenticatedClient _authenticatedClient;

  PostRepository(){
    _client = GetIt.I.get<RestClient>();
    _authenticatedClient = GetIt.I.get<RestAuthenticatedClient>();
  }

  Future<PostResponse> fetchPostPage(int page) async {
    String url = "/post/?page=${page}";

    return PostResponse.fromJson(jsonDecode(await _client.get(url)));
  }

  Future<PostDetails> getPostDetails(int id) async {
    String url = "/post/${id}";

    return PostDetails.fromJson(jsonDecode(await _client.get(url)));
  }
}