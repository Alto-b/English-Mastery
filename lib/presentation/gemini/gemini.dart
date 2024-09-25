import 'package:english_mastery/application/gemini_bloc/gemini_bloc.dart';
import 'package:english_mastery/domain/gemini_model.dart';
import 'package:english_mastery/infrastructure/gemini_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeminiPage extends StatefulWidget {
  const GeminiPage({Key? key}) : super(key: key);

  @override
  _GeminiPageState createState() => _GeminiPageState();
}

class _GeminiPageState extends State<GeminiPage> {
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController chatScrollController = ScrollController();

  late GeminiBloc geminiBloc;
  String? userAvatar;

  @override
  void initState() {
    super.initState();
    geminiBloc = GeminiBloc(geminiRepo: GeminiRepo());
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
  void dispose() {
    textEditingController.dispose();
    chatScrollController.dispose();
    geminiBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Mastery AI"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<GeminiBloc, GeminiState>(
                bloc: geminiBloc,
                listener: (context, state) {
                  if (state is GeminiSuccessState) {
                    scrollToBottom();
                  }
                },
                builder: (context, state) {
                  return Stack(
                    children: [
                      _buildChatList(state),
                      if (geminiBloc.generating) _buildLoadingIndicator(),
                    ],
                  );
                },
              ),
            ),
            _buildHeroInputArea(context),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList(GeminiState state) {
    if (state is GeminiSuccessState) {
      return ListView.builder(
        controller: chatScrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        itemCount: state.messages.length,
        itemBuilder: (context, index) {
          final message = state.messages[index];
          final isUser = message.role == "user";
          return Align(
            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              padding: const EdgeInsets.all(14),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              decoration: BoxDecoration(
                gradient: isUser
                    ? const LinearGradient(
                        colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : const LinearGradient(
                        colors: [Color(0xFFE0E0E0), Color(0xFFBDBDBD)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isUser ? 12 : 0),
                  topRight: Radius.circular(isUser ? 0 : 12),
                  bottomLeft: const Radius.circular(12),
                  bottomRight: const Radius.circular(12),
                ),
              ),
              child: Text(
                message.parts.first.text,
                style: TextStyle(
                  color: isUser ? Colors.white : Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
      );
    } else if (state is GeminiInitial) {
      return Center(
        child: Text(
          "Start a conversation!",
          style: TextStyle(color: Colors.black54, fontSize: 18),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Lottie.asset(
        'assets/loader/loader.json',
        width: 100,
        height: 100,
      ),
    );
  }

  Widget _buildHeroInputArea(BuildContext context) {
    return Hero(
      tag: "searchBar",
      flightShuttleBuilder: (flightContext, animation, flightDirection,
          fromHeroContext, toHeroContext) {
        return Material(
          type: MaterialType.transparency,
          child: toHeroContext.widget,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: textEditingController,
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  hintText: "Ask me something...",
                  hintStyle: TextStyle(color: Colors.black54),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 14.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                textInputAction: TextInputAction.send,
                onSubmitted: (value) => _sendMessage(),
              ),
            ),
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blueAccent,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    if (textEditingController.text.trim().isNotEmpty) {
      String text = textEditingController.text.trim();
      textEditingController.clear();
      geminiBloc.add(
        ChatGenerateNewTextMessageEvent(
          inputMessage: text,
        ),
      );
    }
  }
}
