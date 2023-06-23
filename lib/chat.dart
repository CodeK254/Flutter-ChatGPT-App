import 'package:chat_gpt/Models/gpt_service.dart';
import 'package:flutter/material.dart';
import "package:animated_text_kit/animated_text_kit.dart";

class ChatGPT extends StatefulWidget {
  const ChatGPT({super.key});

  @override
  State<ChatGPT> createState() => _ChatGPTState();
}

class _ChatGPTState extends State<ChatGPT> {
  String response = "";
  List<Map> sent = [];
  TextEditingController controller = TextEditingController();

  void getResponse(String text) async {
    final data = await generateResponse(text);
    setState(() {
      sent.add({"data": text});
      response = data;
      sent.add({"answer": response});
    });
  }

  @override
  void initState() {
    getResponse("Hello!");
    super.initState();
    debugPrint(sent.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        toolbarHeight: 65,
        shadowColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 23,
        ),
        leading: const Icon(
          Icons.menu,
        ),
        title: const Text(
          "Chat-GPT HOME",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: sent.isNotEmpty ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                    sent.length, 
                    (index) => Align(
                      alignment: sent[index]["data"] != null ? Alignment.centerRight : Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.85,
                          ),
                          decoration: BoxDecoration(
                            color: sent[index]["data"] != null ? Colors.grey[300] : Colors.grey[700],
                            borderRadius: BorderRadius.only(
                              topRight: sent[index]["data"] != null ? const Radius.circular(12) : const Radius.circular(12),
                              topLeft: sent[index]["data"] != null ? const Radius.circular(12) : const Radius.circular(12),
                              bottomRight: sent[index]["data"] != null ? const Radius.circular(0) : const Radius.circular(12),
                              bottomLeft: sent[index]["data"] != null ? const Radius.circular(12) : const Radius.circular(0),
                            )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedTextKit(
                              totalRepeatCount: 1,
                              pause: const Duration(seconds: 1),
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  sent[index]["data"] ?? sent[index]["answer"],
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    color: sent[index]["data"] != null ? Colors.black54 : Colors.white,
                                  ),
                                  speed: const Duration(milliseconds: 50),
                                  textAlign: sent[index]["data"] == null ? TextAlign.left : TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 8
            ),
            child: TextFormField(
              style: TextStyle(
                color: Colors.grey[900],
              ),
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey.shade900
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey.shade900
                  ),
                ),
                suffixIcon: GestureDetector(
                  onTap: (){
                    getResponse(controller.text);
                    setState(() {
                      controller.text = "";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.telegram_outlined,
                      color: Colors.blue[800],
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ) : Center(
        child: AnimatedTextKit(
          repeatForever: true,
          pause: const Duration(seconds: 3),
          animatedTexts: [
            TypewriterAnimatedText(
              "Welcome to AskGPT, feel free to ask me anything. I will try to respond in the best way possible",
              textStyle: TextStyle(
                fontSize: 17,
                color: Colors.grey[600],
              ),
              speed: const Duration(milliseconds: 50),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}