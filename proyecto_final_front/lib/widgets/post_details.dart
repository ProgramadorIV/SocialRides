import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final_front/blocs/authentication/authentication.dart';
import 'package:proyecto_final_front/blocs/post_detail/post_detail_bloc.dart';
import 'package:proyecto_final_front/model/models.dart';
import 'package:proyecto_final_front/pages/login_page.dart';
import 'package:proyecto_final_front/widgets/default_img.dart';


class PostDetailsPage extends StatelessWidget{
  
  PostDetailsPage({super.key, required this.id});
  int id;
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (context) => PostDetailBloc()..add(PostDetailFetched(id)),
      child: PostDetailsPageState(),
    );
  }
}

class PostDetailsPageState extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPageState>{

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context); 
    return BlocBuilder<PostDetailBloc, PostDetailState>(builder: (context, state){
      if (state.status == PostDetailStatus.initial){
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      else if(state.status == PostDetailStatus.success){
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){
                authBloc.add(UserLoggedOut());
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                }, 
                icon: Icon(Icons.logout),
                color: Colors.white,
                hoverColor: Colors.red,
                padding: EdgeInsets.all(10),
                )
            ],
            backgroundColor: Colors.lightBlue,
            title: Text(
              'Social Rides',
              style: GoogleFonts.pacifico(
                color: Colors.white
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width > 700 ? 
                (
                  MediaQuery.of(context).size.width > 1450 ? 
                  MediaQuery.of(context).size.width / 2.7 :
                  MediaQuery.of(context).size.width / 2
                ) :
                MediaQuery.of(context).size.width,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.all(15),
                  elevation: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Column(
                      children: <Widget>[
                        Image.network(
                          "http://localhost:8080/download/" + state.postDetails!.img!,
                          errorBuilder: (context, error, stackTrace) => DefaultImg(),
                          fit: BoxFit.contain, 
                          height: 260,
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 0,
                          thickness: 0.2,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10, left: MediaQuery.of(context).size.width/18),
                                child: IconButton(
                                  onPressed: (){}, //Proximamente
                                  iconSize: 25,
                                  icon: Icon(Icons.favorite, color: Colors.white,)
                                )
                              ),
                              Text(
                                state.postDetails!.likes.isEmpty ? 
                                'No likes' 
                                : 
                                (state.postDetails!.likes.length > 1 ?
                                  state.postDetails!.likes[0].username + ' and ' + (state.postDetails!.likes.length - 1).toString() + ' others'
                                  :
                                  'Just ' + state.postDetails!.likes[0].username + " liked it"
                                ),
                                style: GoogleFonts.pacifico(),
                              )
                            ]
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 0,
                          thickness: 0.2,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(state.postDetails!.title, style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ), )//Text(post.title),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(state.postDetails!.description!, style: GoogleFonts.pacifico())//Text(post.description!),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 0,
                          thickness: 0.2,
                        ),
                        GestureDetector(
                          //onTap: () => ,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10, left: MediaQuery.of(context).size.width/18),
                                child: IconButton(
                                  onPressed: (){}, //proximamente
                                  iconSize: 25,
                                  icon: Icon(Icons.comment, color: Colors.white,)
                                )
                              ),
                              Text('Make your own comment!', style: TextStyle(color: Colors.blueAccent))
                            ],
                          )
                        ),
                        Container(
                          child: state.postDetails!.comments.isNotEmpty ? 
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.postDetails!.comments.length,
                            itemBuilder: (BuildContext context, int index){
                              final item = state.postDetails!.comments[index];
                              return SizedBox(
                                  child: ListTile(
                                    leading: Text(item.username , style: GoogleFonts.pacifico()),
                                    subtitle: Text(item.body, style: GoogleFonts.pacifico()),
                                  ),
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                              );
                            }
                          )
                          : 
                          Center(
                            child: Text('No comments yet', style: GoogleFonts.pacifico())
                          )
                        ),
                      ],
                    ),
                  )
              )
            )
          )
          )
        );
      }
      else{
        return Center(
          child: Text('Failed to load post.'),
        );
      }
    });
  }
}