import 'package:english_mastery/application/gemini_bloc/gemini_bloc.dart';
import 'package:english_mastery/domain/gemini_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class GeminiPage extends StatefulWidget {
  const GeminiPage({super.key});

  @override
  _GeminiPageState createState() => _GeminiPageState();
}

class _GeminiPageState extends State<GeminiPage> {
  final TextEditingController textEditingController = TextEditingController();
  final GeminiBloc geminiBloc = GeminiBloc();
  final ScrollController chatScrollController = ScrollController();

  String? userAvatar;

  @override
  void initState() {
    super.initState();
    _loadUserAvatar();
  }

  Future<void> _loadUserAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userAvatar = prefs.getString('userAvatar');
    });
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (chatScrollController.hasClients) {
        chatScrollController.animateTo(
          chatScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeminiBloc, GeminiState>(
      bloc: geminiBloc,
      listener: (context, state) {
        if (state is GeminiSuccessState) {
          scrollToBottom();
        }
      },
      builder: (context, state) {
        if (state is GeminiSuccessState) {
          List<GeminiMessageModel> messages = state.messages;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Gemini Chat'),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: chatScrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: message.role == "user"
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              color: message.role == "user"
                                  ? const Color(0XFF04A3FF).withOpacity(.4)
                                  : const Color.fromARGB(255, 79, 79, 79)
                                      .withOpacity(.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.role == "user" ? "You" : "AI",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(message.parts.first.text),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (geminiBloc.generating)
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Lottie.asset('assets/loader/loader.json'),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  backgroundColor: Colors.grey.shade400,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: RandomAvatar(
                                      userAvatar ?? "",
                                      trBackground: true,
                                    ),
                                  )),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            hintText: "Ask me something",
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: () {
                            if (textEditingController.text.isNotEmpty) {
                              String text = textEditingController.text;
                              textEditingController.clear();
                              geminiBloc.add(
                                ChatGenerateNewTextMessageEvent(
                                  inputMessage: text,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
