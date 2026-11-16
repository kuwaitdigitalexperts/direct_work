import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_model.dart';
import '../services/chat_service.dart';

class ChatState {
  final List<ChatRoomModel> rooms;
  final Map<String, List<ChatMessageModel>> messagesByRoom;
  final bool isLoading;
  final String? error;

  const ChatState({
    this.rooms = const [],
    this.messagesByRoom = const {},
    this.isLoading = false,
    this.error,
  });

  ChatState copyWith({
    List<ChatRoomModel>? rooms,
    Map<String, List<ChatMessageModel>>? messagesByRoom,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      rooms: rooms ?? this.rooms,
      messagesByRoom: messagesByRoom ?? this.messagesByRoom,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ChatNotifier extends StateNotifier<ChatState> {
  final ChatService _service;

  ChatNotifier(this._service) : super(const ChatState()) {
    fetchRooms();
  }

  Future<void> fetchRooms() async {
    state = state.copyWith(isLoading: true);
    try {
      final rooms = await _service.getRooms();
      state = state.copyWith(rooms: rooms, isLoading: false);
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<ChatRoomModel> startOrGetRoom({
    required String participantName,
    required String participantRole,
    required String relatedJobOrService,
    String? initialMessage,
  }) async {
    final room = await _service.createOrGetRoom(
      participantName: participantName,
      participantRole: participantRole,
      relatedJobOrService: relatedJobOrService,
      initialMessage: initialMessage,
    );
    await fetchRooms();
    return room;
  }

  Future<void> fetchMessages(String roomId, String currentUserId) async {
    try {
      final msgs = await _service.getMessages(roomId, currentUserId);
      final updated = Map<String, List<ChatMessageModel>>.from(state.messagesByRoom);
      updated[roomId] = msgs;
      state = state.copyWith(messagesByRoom: updated);
    } catch (_) {}
  }

  Future<void> sendMessage({
    required String roomId,
    required String senderId,
    required String senderName,
    required String messageText,
  }) async {
    final msg = await _service.sendMessage(
      roomId: roomId,
      senderId: senderId,
      senderName: senderName,
      messageText: messageText,
    );

    final updated = Map<String, List<ChatMessageModel>>.from(state.messagesByRoom);
    if (!updated.containsKey(roomId)) {
      updated[roomId] = [];
    }
    updated[roomId] = [...updated[roomId]!, msg];

    // Also update room in state list
    final updatedRooms = state.rooms.map((r) {
      if (r.id == roomId) {
        return ChatRoomModel(
          id: r.id,
          participantName: r.participantName,
          participantRole: r.participantRole,
          lastMessage: messageText,
          lastMessageTime: DateTime.now(),
          unreadCount: 0,
          relatedJobOrService: r.relatedJobOrService,
        );
      }
      return r;
    }).toList();

    state = state.copyWith(messagesByRoom: updated, rooms: updatedRooms);
  }
}

final chatServiceProvider = Provider<ChatService>((ref) => ChatService());

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier(ref.watch(chatServiceProvider));
});
