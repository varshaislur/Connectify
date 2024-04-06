import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final bool isLiked;
  void Function()? onTap;
   LikeButton({super.key,required this.isLiked,required this.onTap});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  User user= FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed:widget.onTap
        , icon:Icon(
    widget.isLiked? Icons.favorite : Icons.favorite_border,
    color: widget.isLiked? Colors.red: Colors.grey,

    ),
    );
  }
}
