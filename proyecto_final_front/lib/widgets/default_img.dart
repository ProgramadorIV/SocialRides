import 'package:flutter/widgets.dart';

class DefaultImg extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FadeInImage(
      placeholder: NetworkImage('https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg'),
      image: NetworkImage('https://www.concretewavemagazine.com/wp-content/uploads/2021/07/how-to-push-on-a-skateboard.jpg')
    );
  }

}