import 'package:chat_gpt/chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const ChatGPT(),
      },
      theme: ThemeData.dark(),
    )
  );
}