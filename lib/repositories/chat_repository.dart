import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telegram_app/exceptions/chat_repository_exception.dart';
import 'package:telegram_app/extensions/future_map.dart';
import 'package:telegram_app/misc/mappers/firebase_mapper.dart';
import 'package:telegram_app/models/chat.dart';
import 'package:telegram_app/models/user.dart';

class ChatRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseMapper<Chat> chatMapper;
  final FirebaseMapper<User> userMapper;

  ChatRepository({
    required this.firebaseFirestore,
    required this.chatMapper,
    required this.userMapper,
  });

  Stream<List<Chat>> chats(String uid) => firebaseFirestore
      .collection('chats')
      .where('users',
          arrayContainsAny: [firebaseFirestore.collection('users').doc(uid)])
      .snapshots()
      .asyncMap(
        (snapshot) => snapshot.docs.futureMap<Chat>(
          (chatSnapshot) async {
            final chat = chatMapper.fromFirebase(chatSnapshot.data());

            final userReference = (chatSnapshot.data()['users'] as List)
                .firstWhere((userReference) => userReference.id != uid,
                    orElse: () => null);

            if (userReference == null) {
              throw new ChatRepositoryException();
            }

            final userSnapshot = await userReference.get();
            final user = userMapper
                .fromFirebase(userSnapshot.data())
                .copyWith(id: userSnapshot.id);

            return chat.copyWith(
              user: user,
              id: chatSnapshot.id,
            );
          },
        ),
      );
}
