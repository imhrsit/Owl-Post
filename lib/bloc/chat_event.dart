part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class ChatGeneratenewTextMessageEvent extends ChatEvent{
  final String inputMessage;

  ChatGeneratenewTextMessageEvent({required this.inputMessage});
}
