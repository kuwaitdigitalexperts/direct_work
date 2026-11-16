class ChatMessageModel {
  final String id;
  final String roomId;
  final String senderId;
  final String senderName;
  final String message;
  final DateTime createdAt;
  final bool isMe;

  const ChatMessageModel({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.createdAt,
    required this.isMe,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json, String currentUserId) {
    final sender = json['sender_id']?.toString() ?? '';
    return ChatMessageModel(
      id: json['id']?.toString() ?? '',
      roomId: json['room_id']?.toString() ?? '',
      senderId: sender,
      senderName: json['sender_name'] ?? 'مستخدم',
      message: json['message'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      isMe: sender == currentUserId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'room_id': roomId,
      'sender_id': senderId,
      'sender_name': senderName,
      'message': message,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class ChatRoomModel {
  final String id;
  final String participantName;
  final String? participantAvatar;
  final String participantRole;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final String relatedJobOrService;

  const ChatRoomModel({
    required this.id,
    required this.participantName,
    this.participantAvatar,
    required this.participantRole,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    required this.relatedJobOrService,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      id: json['id']?.toString() ?? '',
      participantName: json['participant_name'] ?? 'طرف المحادثة',
      participantAvatar: json['participant_avatar'],
      participantRole: json['participant_role'] ?? 'صاحب عمل',
      lastMessage: json['last_message'] ?? '',
      lastMessageTime: json['last_message_time'] != null
          ? DateTime.tryParse(json['last_message_time'].toString()) ?? DateTime.now()
          : DateTime.now(),
      unreadCount: int.tryParse(json['unread_count']?.toString() ?? '0') ?? 0,
      relatedJobOrService: json['related_title'] ?? 'وظيفة شاغرة',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participant_name': participantName,
      'participant_avatar': participantAvatar,
      'participant_role': participantRole,
      'last_message': lastMessage,
      'last_message_time': lastMessageTime.toIso8601String(),
      'unread_count': unreadCount,
      'related_title': relatedJobOrService,
    };
  }
}
