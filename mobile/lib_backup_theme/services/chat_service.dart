import '../core/network/api_client.dart';
import '../core/network/api_endpoints.dart';
import '../models/chat_model.dart';

class ChatService {
  final ApiClient _client = ApiClient();

  // In-memory runtime store for real user-initiated chats and messages
  static final List<ChatRoomModel> _localRooms = [];
  static final Map<String, List<ChatMessageModel>> _localMessages = {};

  Future<List<ChatRoomModel>> getRooms() async {
    try {
      final response = await _client.dio.get(ApiEndpoints.chatRooms);
      if (response.data != null && response.data['data'] is List) {
        final serverRooms = (response.data['data'] as List)
            .map((r) => ChatRoomModel.fromJson(r))
            .toList();

        // Merge server rooms and local rooms without duplicates
        final Set<String> ids = {};
        final List<ChatRoomModel> combined = [];
        for (final r in [...serverRooms, ..._localRooms]) {
          if (!ids.contains(r.id)) {
            ids.add(r.id);
            combined.add(r);
          }
        }
        return combined;
      }
    } catch (_) {}
    return List.unmodifiable(_localRooms);
  }

  Future<ChatRoomModel> createOrGetRoom({
    required String participantName,
    required String participantRole,
    required String relatedJobOrService,
    String? initialMessage,
  }) async {
    // Check if room already exists locally
    final existingIndex = _localRooms.indexWhere(
      (r) => r.participantName.trim().toLowerCase() == participantName.trim().toLowerCase(),
    );
    if (existingIndex >= 0) {
      return _localRooms[existingIndex];
    }

    final roomId = 'room_${DateTime.now().millisecondsSinceEpoch}';
    final newRoom = ChatRoomModel(
      id: roomId,
      participantName: participantName,
      participantRole: participantRole,
      lastMessage: initialMessage ?? '',
      lastMessageTime: DateTime.now(),
      unreadCount: 0,
      relatedJobOrService: relatedJobOrService,
    );

    try {
      final response = await _client.dio.post(
        ApiEndpoints.chatRooms,
        data: {
          'room_id': roomId,
          'participant_name': participantName,
          'participant_role': participantRole,
          'related_job_or_service': relatedJobOrService,
          'initial_message': initialMessage ?? '',
        },
      );
      if (response.data != null && response.data['data'] != null) {
        final created = ChatRoomModel.fromJson(response.data['data']);
        _localRooms.insert(0, created);
        return created;
      }
    } catch (_) {}

    _localRooms.insert(0, newRoom);
    if (initialMessage != null && initialMessage.isNotEmpty) {
      _localMessages[roomId] = [
        ChatMessageModel(
          id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
          roomId: roomId,
          senderId: 'kw_user_1',
          senderName: 'أنا',
          message: initialMessage,
          createdAt: DateTime.now(),
          isMe: true,
        ),
      ];
    }
    return newRoom;
  }

  Future<List<ChatMessageModel>> getMessages(String roomId, String currentUserId) async {
    try {
      final response = await _client.dio.get('${ApiEndpoints.chatMessages}/$roomId/messages');
      if (response.data != null && response.data['data'] is List) {
        final serverMsgs = (response.data['data'] as List)
            .map((m) => ChatMessageModel.fromJson(m, currentUserId))
            .toList();
        if (serverMsgs.isNotEmpty) {
          _localMessages[roomId] = serverMsgs;
          return serverMsgs;
        }
      }
    } catch (_) {}

    return List.unmodifiable(_localMessages[roomId] ?? []);
  }

  Future<ChatMessageModel> sendMessage({
    required String roomId,
    required String senderId,
    required String senderName,
    required String messageText,
  }) async {
    final msg = ChatMessageModel(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      roomId: roomId,
      senderId: senderId,
      senderName: senderName,
      message: messageText,
      createdAt: DateTime.now(),
      isMe: true,
    );

    // Save locally immediately
    if (!_localMessages.containsKey(roomId)) {
      _localMessages[roomId] = [];
    }
    _localMessages[roomId]!.add(msg);

    // Update room last message locally
    final roomIdx = _localRooms.indexWhere((r) => r.id == roomId);
    if (roomIdx >= 0) {
      final room = _localRooms[roomIdx];
      _localRooms[roomIdx] = ChatRoomModel(
        id: room.id,
        participantName: room.participantName,
        participantRole: room.participantRole,
        lastMessage: messageText,
        lastMessageTime: DateTime.now(),
        unreadCount: 0,
        relatedJobOrService: room.relatedJobOrService,
      );
    }

    try {
      await _client.dio.post(
        '${ApiEndpoints.sendMessage}/$roomId/send',
        data: msg.toJson(),
      );
    } catch (_) {}

    return msg;
  }
}
