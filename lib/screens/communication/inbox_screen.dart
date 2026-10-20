import 'package:flutter/material.dart';
import '../../models/chat_message_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_search_bar.dart';
import 'chat_screen.dart';

class InboxScreen extends StatefulWidget {
  final VoidCallback? onBackTap;

  const InboxScreen({
    super.key,
    this.onBackTap,
  });

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final List<ChatContactModel> _contacts = List.from(mockContacts);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Custom Chats App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: widget.onBackTap ?? () => Navigator.of(context).maybePop(),
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
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=80',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Chats',
                    style: AppTextStyles.title.copyWith(fontSize: 18),
                  ),
                  const Spacer(),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.cardBorder, width: 1.2),
                    ),
                    child: const Icon(
                      Icons.more_horiz_rounded,
                      color: AppColors.textPrimary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.divider, thickness: 1),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    // Search Bar
                    const CustomSearchBar(),
                    const SizedBox(height: 20),

                    // Stories Horizontal Carousel
                    SizedBox(
                      height: 95,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          // Add Story Circle
                          Column(
                            children: [
                              Container(
                                width: 62,
                                height: 62,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.cardBorder, width: 1.5),
                                ),
                                child: const Center(
                                  child: Icon(Icons.add, size: 28, color: AppColors.textPrimary),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Add story',
                                style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(width: 14),

                          // Contact Stories
                          ..._contacts.map((contact) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 14),
                              child: Column(
                                children: [
                                  Container(
                                    width: 62,
                                    height: 62,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppColors.accentBlue, width: 2),
                                      image: DecorationImage(
                                        image: NetworkImage(contact.avatarUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    contact.name.split(' ').first,
                                    style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Chats List
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _contacts.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final contact = _contacts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ChatScreen(
                                  contactName: contact.name,
                                  contactAvatar: contact.avatarUrl,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                // Avatar with online indicator
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 26,
                                      backgroundImage: NetworkImage(contact.avatarUrl),
                                    ),
                                    if (contact.isOnline)
                                      Positioned(
                                        bottom: 0,
                                        right: 2,
                                        child: Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            color: AppColors.green,
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.white, width: 2),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(width: 14),

                                // Name and Last message
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        contact.name,
                                        style: AppTextStyles.titleSmall.copyWith(fontSize: 15),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        contact.lastMessage,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.caption.copyWith(
                                          color: contact.unreadCount > 0
                                              ? AppColors.textPrimary
                                              : AppColors.textSecondary,
                                          fontWeight: contact.unreadCount > 0
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Timestamp and Unread badge
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (contact.unreadCount > 0)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                        decoration: const BoxDecoration(
                                          color: AppColors.accentBlue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          '${contact.unreadCount}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    const SizedBox(height: 4),
                                    Text(
                                      contact.time,
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppColors.textMuted,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
