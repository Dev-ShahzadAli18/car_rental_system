import 'package:flutter/material.dart';
import '../../models/chat_message_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

class ChatScreen extends StatefulWidget {
  final String contactName;
  final String contactAvatar;

  const ChatScreen({
    super.key,
    required this.contactName,
    required this.contactAvatar,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController(
    text: "I'll complete the booking now. Thank you!",
  );

  final List<ChatMessage> _messages = [
    const ChatMessage(
      id: 'm1',
      text: 'Ready for your next adventure? Book a car today and get 20% off your first rental!\nDon\'t miss out—limited-time offer. Reserve your ride now!',
      time: '09:05 am',
      isMe: false,
    ),
    const ChatMessage(
      id: 'm2',
      text: 'Hi, I\'m interested in renting your car. Is it available from 19 Jan to 22 Jan?',
      time: '09:10 am',
      isMe: true,
    ),
    const ChatMessage(
      id: 'm3',
      text: 'Hello! Yes, the car is available on those dates. Could you please confirm the pickup and drop-off locations?',
      time: '09:15 am',
      isMe: false,
    ),
    const ChatMessage(
      id: 'm4',
      text: 'Great! I\'d like to pick it up from Shore Dr, Chicago and return it to the same location.',
      time: '09:17 am',
      isMe: true,
    ),
    const ChatMessage(
      id: 'm5',
      text: 'It\'s ok no problem',
      time: '09:19 am',
      isMe: false,
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: _messageController.text.trim(),
          time: 'Now',
          isMe: true,
        ),
      );
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Chat App Bar with Call & Video Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.cardBorder, width: 1.2),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Avatar with Online dot
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(widget.contactAvatar),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),

                  // Contact Name & Status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.contactName,
                        style: AppTextStyles.titleSmall.copyWith(fontSize: 16),
                      ),
                      Text(
                        'Online',
                        style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  const Spacer(),

                  // Video Call Icon
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.videocam_outlined, color: AppColors.textPrimary, size: 26),
                  ),
                  // Phone Call Icon
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.phone_outlined, color: AppColors.textPrimary, size: 22),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.divider, thickness: 1),

            // Partner Subtitle Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Text(
                    widget.contactName,
                    style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Partner of QENT',
                    style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),

            // Message Stream
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return _buildMessageItem(message);
                },
              ),
            ),

            // Typing Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(widget.contactAvatar),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Typing......',
                    style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),

            // Bottom Input Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.divider, width: 1)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.cardBorder, width: 1.2),
                    ),
                    child: const Icon(Icons.chevron_right_rounded, color: AppColors.textPrimary),
                  ),
                  const SizedBox(width: 10),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F7F9),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              style: AppTextStyles.bodySmall,
                              decoration: const InputDecoration(
                                hintText: 'Type a message...',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const Icon(Icons.sentiment_satisfied_alt_outlined, color: AppColors.textSecondary),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryDark,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.send_rounded, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageItem(ChatMessage message) {
    if (message.isMe) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 280),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x08000000),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textPrimary,
                  height: 1.35,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message.time,
              style: AppTextStyles.caption.copyWith(color: AppColors.textMuted, fontSize: 10),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 14,
              backgroundImage: NetworkImage(widget.contactAvatar),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 280),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F7F9),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                    border: Border.all(color: AppColors.cardBorder, width: 1),
                  ),
                  child: Text(
                    message.text,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textPrimary,
                      height: 1.35,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.time,
                  style: AppTextStyles.caption.copyWith(color: AppColors.textMuted, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
