import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvartaImageWidget extends StatelessWidget {
  const AvartaImageWidget({
    Key? key,
    required this.avartaHeight,
  }) : super(key: key);

  final double avartaHeight;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: avartaHeight / 2,
      backgroundColor: Colors.white,
      backgroundImage: AssetImage("images/profile.jpg"),
    );
  }
}
