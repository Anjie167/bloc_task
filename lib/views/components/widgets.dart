import 'package:flutter/material.dart';

AppBar buildAppBar(String text, bool center) {
  return AppBar(
    elevation: 2.0,
    backgroundColor: Colors.white,
    title: Text(
      text,
      style: const TextStyle(color: Colors.black),
    ),
    centerTitle: center,
  );
}

Padding trackDetail(
    String text,
    String value,
    ) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20,),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 26),
          maxLines: 2,
        ),
      ],
    ),
  );
}
