import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:transfert_colis_interurbain/App/Manager/ContactManager.dart';
import 'package:transfert_colis_interurbain/Domain/Model/Contact.dart';
import 'package:transfert_colis_interurbain/Domain/Model/Message.dart';
import 'package:transfert_colis_interurbain/Domain/Model/UserApp.dart';
import '../../../Domain/Model/UserApp.dart';
import '../constants/constants.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';
import 'pages.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.arguments});

  final ChatPageArguments arguments;

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  late final String currentUserId;

  List<QueryDocumentSnapshot> listMessage = [];
  int _limit = 20;
  int _limitIncrement = 20;
  String groupChatId = "";

  File? imageFile;
  bool isLoading = false;
  bool isShowSticker = false;
  String imageUrl = "";

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);
    //readLocal();
  }

  _scrollListener() {
    if (!listScrollController.hasClients) return;
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        _limit <= listMessage.length) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  // void readLocal() {
  //   String peerId = widget.arguments.peerId;
  //   if (currentUserId.compareTo(peerId) > 0) {
  //     groupChatId = '$currentUserId-$peerId';
  //   } else {
  //     groupChatId = '$peerId-$currentUserId';
  //   }

  //   chatProvider.updateDataFirestore(
  //     FirestoreConstants.pathUserCollection,
  //     currentUserId,
  //     {FirestoreConstants.chattingWith: peerId},
  //   );
  // }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker
        .pickImage(source: ImageSource.gallery)
        .catchError((err) {
      Fluttertoast.showToast(msg: err.toString());
      return null;
    });
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        uploadFile();
      }
    }
  }

  // void getSticker() {
  //   // Hide keyboard when sticker appear
  //   focusNode.unfocus();
  //   setState(() {
  //     isShowSticker = !isShowSticker;
  //   });
  // }

  Future uploadFile() async {
    // String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    // UploadTask uploadTask = chatProvider.uploadFile(imageFile!, fileName);
    // try {
    //   TaskSnapshot snapshot = await uploadTask;
    //   imageUrl = await snapshot.ref.getDownloadURL();
    //   setState(() {
    //     isLoading = false;
    //     //onSendMessage(imageUrl, TypeMessage.image);
    //   });
    // } on FirebaseException catch (e) {
    //   setState(() {
    //     isLoading = false;
    //   });
    //   Fluttertoast.showToast(msg: e.message ?? e.toString());
    // }
  }

  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();

      ContactManager().addMessage(
          widget.arguments.contact, Message(content, DateTime.now()));

      // chatProvider.sendMessage(
      //     content, type, groupChatId, currentUserId, widget.arguments.peerId);

      if (listScrollController.hasClients) {
        listScrollController.animateTo(0,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send', backgroundColor: ColorConstants.greyColor);
    }
  }

  Widget buildItem(int index, BuildContext context, Message message) {
    final user = Provider.of<UserApp>(context);

    if (message != null) {
      if (widget.arguments.contact.user1.userId == user.userId) {
        // Right (my message)
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              width: 200,
              decoration: BoxDecoration(
                  color: ColorConstants.greyColor2,
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.only(
                  bottom: isLastMessageRight(index) ? 20 : 10, right: 10),
              child: Text(
                message.message,
                style: const TextStyle(color: ColorConstants.primaryColor),
              ),
            )
          ],
        );
      } else {
        UserApp usertemp;
        user.userId == widget.arguments.contact.user1.userId!
            ? usertemp = widget.arguments.contact.user2
            : usertemp = widget.arguments.contact.user1;

        // Left (peer message)
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  isLastMessageLeft(index)
                      ? Material(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Image.network(
                            usertemp.userPhoto!,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: ColorConstants.themeColor,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, object, stackTrace) {
                              return const Icon(
                                Icons.account_circle,
                                size: 35,
                                color: ColorConstants.greyColor,
                              );
                            },
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(width: 35),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    width: 200,
                    decoration: BoxDecoration(
                        color: ColorConstants.primaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      message.message,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),

              // Time
              isLastMessageLeft(index)
                  ? Container(
                      margin:
                          const EdgeInsets.only(left: 50, top: 5, bottom: 5),
                      child: Text(
                        DateFormat('dd MMM kk:mm').format(message.timestamp),
                        style: const TextStyle(
                            color: ColorConstants.greyColor,
                            fontSize: 12,
                            fontStyle: FontStyle.italic),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  bool isLastMessageLeft(int index) {
    if (widget.arguments.contact.messages.length == index - 1) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if (widget.arguments.contact.messages.length == index - 1) {
      return true;
    } else {
      return false;
    }
  }

  // Future<bool> onBackPress() {
  //   if (isShowSticker) {
  //     setState(() {
  //       isShowSticker = false;
  //     });
  //   } else {
  //     chatProvider.updateDataFirestore(
  //       FirestoreConstants.pathUserCollection,
  //       currentUserId,
  //       {FirestoreConstants.chattingWith: null},
  //     );
  //     Navigator.pop(context);
  //   }

  //   return Future.value(false);
  //}

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserApp>(context);
    UserApp usertemp;
    user.userId == widget.arguments.contact.user1.userId!
        ? usertemp = widget.arguments.contact.user2
        : usertemp = widget.arguments.contact.user1;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${usertemp.userName!.toUpperCase()} ${usertemp.userSurname!.toUpperCase()}",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // List of messages
                buildListMessage(),

                // Input content
                buildInput(),
              ],
            ),

            // Loading
            buildLoading()
          ],
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading ? LoadingView() : SizedBox.shrink(),
    );
  }

  Widget buildInput() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(color: ColorConstants.greyColor2, width: 0.5)),
          color: Colors.white),
      child: Row(
        children: [
          // Button send image
          Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: const Icon(Icons.image),
                //onPressed: getImage,
                onPressed: () {},
                color: ColorConstants.primaryColor,
              ),
            ),
          ),
          Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: const Icon(Icons.face),
                //onPressed: getSticker,
                onPressed: () {},
                color: ColorConstants.primaryColor,
              ),
            ),
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  onSendMessage(
                    textEditingController.text,
                    TypeMessage.text,
                  );
                },
                style: const TextStyle(
                    color: ColorConstants.primaryColor, fontSize: 15),
                controller: textEditingController,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Entrer votre message...',
                  hintStyle: TextStyle(color: ColorConstants.greyColor),
                ),
                focusNode: focusNode,
                autofocus: true,
              ),
            ),
          ),

          // Button send message
          Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () =>
                    onSendMessage(textEditingController.text, TypeMessage.text),
                color: ColorConstants.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListMessage() {
    return Flexible(
        child: StreamBuilder(
      stream: ContactManager().getMessageofContact(widget.arguments.contact),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageData = snapshot.data!;

          if (messageData.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) =>
                  buildItem(index, context, messageData.elementAt(index)),
              itemCount: messageData.length,
              reverse: false,
              controller: listScrollController,
            );
          } else {
            return const Center(child: Text("Aucun message..."));
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: ColorConstants.themeColor,
            ),
          );
        }
      },
    ));
  }
}

class ChatPageArguments {
  final Contact contact;
  ChatPageArguments({required this.contact});
}
