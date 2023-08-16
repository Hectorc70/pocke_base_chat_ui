// ignore_for_file: implementation_imports

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:chatview/chatview.dart';
import 'package:pocketbase_chat/app/data/helper.dart';
import 'chatting_controller.dart';
import 'package:chatview/src/models/voice_message_configuration.dart';

class ChattingView extends GetView<ChattingController> {
  const ChattingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            ChatView(
              appBar: AppBar(
                title:
                    Text(controller.chatsRoom.name?.capitalizeFirst ?? "Chat"),
                backgroundColor: Colors.black,
              ),
              chatBubbleConfig: ChatBubbleConfiguration(
                  outgoingChatBubbleConfig: ChatBubble(
                    color: Colors.black,
                  ),
                  inComingChatBubbleConfig: ChatBubble(
                    color: Colors.black,
                  )),
              chatController: controller.chatController,
              currentUser: controller.currentUser,
              chatViewState: controller.chatViewState.value,
              onSendTap: controller.onSendTap,
              chatViewStateConfig: ChatViewStateConfiguration(
                onReloadButtonTap: controller.loadChats,
              ),
              messageConfig: MessageConfiguration(
                  voiceMessageConfig: VoiceMessageConfiguration(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    playIcon: const Icon(Icons.play_arrow, color: Colors.white),
                    pauseIcon: const Icon(Icons.pause, color: Colors.white),
                  ),
                  customMessageBuilder: (message) {
                    final nameSplit = message.message.split('/');
                    String nameFile = nameSplit[nameSplit.length - 1];

                    print(nameFile);
                    return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: const BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                        width: 70.0,
                        height: 70.0,
                        child: const Icon(
                          Icons.file_open_rounded,
                          color: Colors.white,
                        ));
                  }),
              sendMessageConfig: SendMessageConfiguration(
                textFieldBackgroundColor: Colors.grey[200],
                textFieldConfig: TextFieldConfiguration(
                  textStyle: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            Positioned(
              bottom: 11.0,
              right: 125.0,
              child: IconButton(
                  onPressed: () async {
                    File? response = await getFile();
                    if (response != null) {
                      // Message(
                      //   createdAt: DateTime.now(),
                      //   message: response.toString(),
                      //   sendBy: controller.currentUser.id,
                      //   messageType: MessageType.image,
                      // );
                      controller.onSendTap(response.path.toString(),
                          const ReplyMessage(), MessageType.custom);
                      print('FILE=====');
                    }
                  },
                  icon: const Icon(
                    Icons.attach_file_rounded,
                    color: Colors.black,
                    size: 23.0,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
