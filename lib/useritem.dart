import 'package:crud_firebase/userdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';

class UserItem extends StatefulWidget {
  UserData userData;
  UserItem(this.userData);

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  Gravatar? gravatar;

  @override
  void initState() {
    /// default values to use in displaying
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    gravatar = Gravatar(widget.userData.email);
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          CircleAvatar(
            // backgroundColor: Colors.lightBlue,
            // child: Text(
            //   userData.nama[0].toUpperCase(),
            //   style: TextStyle(color: Colors.white)
            // ),
            backgroundImage: NetworkImage(gravatar!.imageUrl()),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userData.nama,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Umur : " +
                    widget.userData.umur.toString() +
                    " " +
                    "Email : " +
                    widget.userData.email),
              ],
            ),
          )
        ],
      ),
    );
  }
}
