import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String user; // "Patient" or "Guardian"
  const ChatScreen({required this.user, super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();

  // ✅ External call to add SOS/System message
  static void addSystemMessage(String text) {
    final now = DateTime.now();
    final time = DateFormat('hh:mm a').format(now);
    _ChatScreenState.chatMessages.add({
      "from": "System",
      "text": text,
      "time": time,
    });
  }
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  // ✅ Shared static chat list
  static List<Map<String, String>> chatMessages = [];

  // ⏰ Time formatter
  String _getTime() {
    final now = DateTime.now();
    return DateFormat('hh:mm a').format(now);
  }

  // ✅ Send user message
  void sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      chatMessages.add({
        "from": widget.user,
        "text": text,
        "time": _getTime(),
      });
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: chatMessages.map((msg) {
                final isSender = msg['from'] == widget.user;
                final isSystem = msg['from'] == "System";
                return Align(
                  alignment: isSystem
                      ? Alignment.center
                      : isSender
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSystem
                          ? Colors.orange.shade100
                          : isSender
                              ? Colors.indigo.shade100
                              : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: isSystem
                          ? CrossAxisAlignment.center
                          : isSender
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${msg['from']} • ${msg['time']}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                            fontStyle:
                                isSystem ? FontStyle.italic : FontStyle.normal,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          msg['text'] ?? '',
                          style: const TextStyle(fontSize: 16),
                          textAlign:
                              isSystem ? TextAlign.center : TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => sendMessage(),
                    decoration: const InputDecoration(
                      hintText: "Type your message",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
