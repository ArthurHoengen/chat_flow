import 'package:chat_flow/colors.dart';
import 'package:flutter/material.dart';
import '../modules/message.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final List<Message> messages = [];
  final TextEditingController messageController = TextEditingController();

  void _sendMessage() {
    final String text = messageController.text;
    String sender = 'Você'; //sera alterado
    final DateTime timestamp = DateTime.now();

    final Message newMessage = Message(
      text: text,
      sender: sender,
      timestamp: timestamp,
    );

    setState(() {
      messages.add(newMessage);
      messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final String contactName =
        ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(contactName),
        leadingWidth: 45,
        leading: CircleAvatar(
            // Imagem do perfil do contato
            child: contactName == ""
                ? const Icon(Icons.account_circle)
                : Text(contactName[0].toUpperCase())),
        backgroundColor: CF_purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final Message message = messages[index];
                return ListTile(
                  title: Text(message.sender),
                  subtitle: Text(message.text),
                );
              },
            ),
          ),
          const Divider(height: 1.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration:
                        const InputDecoration(hintText: 'Digite sua mensagem...'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    _sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
