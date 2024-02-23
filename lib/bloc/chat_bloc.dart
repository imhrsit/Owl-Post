import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:owl_post/models/chat_message_model.dart';
import 'package:owl_post/repos/chat_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSuccessState(messages: [])) {
    on<ChatGeneratenewTextMessageEvent>(chatGeneratenewTextMessageEvent);
  }

      List<ChatMessageModel> messages = []; 

  FutureOr<void> chatGeneratenewTextMessageEvent(
    ChatGeneratenewTextMessageEvent event, Emitter<ChatState> emit) async{
      messages.add(ChatMessageModel(roles: 'user', parts: [
        ChatPartModel(text: event.inputMessage)
      ]));
      emit(ChatSuccessState(messages: messages));

      await ChatRepo.ChatTextGenerationRepo(messages);
    }
}
