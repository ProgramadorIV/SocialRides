import 'package:flutter/material.dart';
import 'package:proyecto_final_front/model/models.dart';
import 'package:proyecto_final_front/widgets/default_img.dart';
import 'package:proyecto_final_front/widgets/post_details.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({super.key, required this.post});

  final Post post;
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
      onTap: () => Navigator.push(
        context, MaterialPageRoute(
          builder: (context) => PostDetailsPage(id: post.id)
          )
        ),
      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            margin: EdgeInsets.all(15),
            elevation: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Column(
                children: <Widget>[
                  Image.network(
                    "http://localhost:8080/download/" + post.img!,
                    errorBuilder: (context, error, stackTrace) => DefaultImg(),
                    fit: BoxFit.contain, 
                    height: 260,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(post.title),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(post.description!),
                  ),
                ],
              ),
            )
          )
      )
    )
    );
  }

}