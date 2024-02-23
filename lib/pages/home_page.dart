import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:owl_post/bloc/chat_bloc.dart';
import 'package:owl_post/models/chat_message_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatBloc chatBloc = ChatBloc();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              List<ChatMessageModel> messages =
                  (state as ChatSuccessState).messages;
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        opacity: 0.5,
                        image: AssetImage("assets/hogwarts_bg.jpeg"),
                        fit: BoxFit.cover)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 100,
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Owl Post",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          Icon(
                            Icons.image_search,
                            color: Colors.white,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: const EdgeInsets.only(bottom: 8, left: 10, right: 10),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.blueGrey.withOpacity(0.6)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        messages[index].role == "user"
                                            ? "Harsh"
                                            : "Owl AI",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                messages[index].role == "user"
                                                    ? Colors.amber
                                                    : Colors.purple.shade200),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        messages[index].parts.first.text,
                                        style: TextStyle(height: 1.2),
                                      ),
                                    ],
                                  ));
                            })),
                    if (chatBloc.generating)
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 22),
                              height: 100,
                              width: 100,
                              child: Lottie.asset('assets/loader.json')),
                          const SizedBox(width: 25),
                          Text("hunting...")
                        ],
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: textEditingController,
                            style: TextStyle(color: Colors.black),
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                fillColor: Colors.white,
                                hintText: "Ask Something",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade400),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).primaryColor))),
                          )),
                          const SizedBox(width: 12),
                          InkWell(
                            onTap: () {
                              if (textEditingController.text.isNotEmpty) {
                                String text = textEditingController.text;
                                textEditingController.clear();
                                chatBloc.add(ChatGeneratenewTextMessageEvent(
                                    inputMessage: text));
                              }
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 27,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Center(
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white
                                    ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
