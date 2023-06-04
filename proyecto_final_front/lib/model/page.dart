/*import 'package:json_annotation/json_annotation.dart';
import 'package:proyecto_final_front/model/models.dart';

@JsonSerializable()
class Pageable<T> {
  
  late List<dynamic>? content;
  late bool last;
  late int totalPages;
  late int totalElements;
  late bool first;
  late int currentPage;

  Pageable();

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable()
  ..content = (json['content'] as List<T>?)
      ?.map((e) => _castToType(e).fromJson(e as Map<String, dynamic>))
      .toList()
  ..last = json['last'] as bool
  ..totalPages = json['totalPages'] as int
  ..totalElements = json['totalElements'] as int
  ..first = json['first'] as bool
  ..currentPage = json['currentPage'] as int;

  static dynamic _castToType(dynamic value){
    if(value is Post)
      return Post;
    /*else if(value is )
      return */
    else{
      print('ME CAGO EN TU PUTA MDRE');
      throw ArgumentError();
    }
  }
}*/