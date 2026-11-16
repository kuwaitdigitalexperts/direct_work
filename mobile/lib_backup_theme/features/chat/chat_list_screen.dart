import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localizations.dart';
import '../../models/chat_model.dart';
import '../../providers/chat_provider.dart';

class ChatListScreen extends ConsumerStatefulWidget {
  const ChatListScreen({super.key});

  @override
  ConsumerState<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final chatState = ref.watch(chatProvider);

    final filteredRooms = chatState.rooms.where((room) {
      if (_searchQuery.trim().isEmpty) return true;
      final q = _searchQuery.trim().toLowerCase();
      return room.participantName.toLowerCase().contains(q) ||
          room.lastMessage.toLowerCase().contains(q) ||
          room.relatedJobOrService.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          l10n.translate('tab_chats'),
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1E293B),
            letterSpacing: -0.5,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar (Exact Reference Match to Image 3)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9), // Light grey fill
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: l10n.translate('search_conversations_hint'),
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF94A3B8),
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Color(0xFF94A3B8),
                      size: 22,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18, color: Color(0xFF94A3B8)),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ),

            // Content: Empty State or Conversation Rooms
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref.read(chatProvider.notifier).fetchRooms(),
                color: AppColors.primary,
                child: chatState.isLoading
                    ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                    : filteredRooms.isEmpty
                        ? ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.16),
                              Center(
                                child: Container(
                                  width: 84,
                                  height: 84,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEFF6FF), // Light ice blue
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFFBFDBFE), // Soft blue border
                                      width: 2.5,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.chat_bubble_outline_rounded,
                                    size: 42,
                                    color: Color(0xFF2563EB),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                l10n.translate('no_chats'),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                l10n.translate('no_chats_desc_reference'),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF64748B),
                                  height: 1.45,
                                ),
                              ),
                            ],
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            itemCount: filteredRooms.length,
                            separatorBuilder: (_, __) => const Divider(height: 1, indent: 76),
                            itemBuilder: (context, index) {
                              final room = filteredRooms[index];
                              return ListTile(
                                onTap: () {
                                  context.push(
                                    '/chat/${room.id}?name=${Uri.encodeComponent(room.participantName)}&role=${Uri.encodeComponent(room.participantRole)}',
                                  );
                                },
                                leading: CircleAvatar(
                                  radius: 26,
                                  backgroundColor: AppColors.primaryLight,
                                  child: Text(
                                    room.participantName.isNotEmpty ? room.participantName.substring(0, 1) : 'C',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        room.participantName,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      _formatTime(room.lastMessageTime, l10n),
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 2),
                                    if (room.relatedJobOrService.isNotEmpty)
                                      Text(
                                        room.relatedJobOrService,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: AppColors.primaryDark,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    const SizedBox(height: 2),
                                    Text(
                                      room.lastMessage.isNotEmpty
                                          ? room.lastMessage
                                          : (l10n.isArabic ? 'بدء المحادثة...' : 'Conversation started...'),
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: room.unreadCount > 0 ? AppColors.textPrimary : AppColors.textSecondary,
                                        fontWeight: room.unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                trailing: room.unreadCount > 0
                                    ? Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          color: AppColors.primary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          '${room.unreadCount}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    : null,
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt, AppLocalizations l10n) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} ${l10n.isArabic ? "د" : "m"}';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} ${l10n.isArabic ? "س" : "h"}';
    } else {
      return '${diff.inDays} ${l10n.isArabic ? "ي" : "d"}';
    }
  }
}
