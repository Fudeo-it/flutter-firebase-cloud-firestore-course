import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telegram_app/misc/mappers/firebase_mapper.dart';
import 'package:telegram_app/models/user.dart';

class UserRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseMapper<User> userMapper;

  UserRepository({
    required this.firebaseFirestore,
    required this.userMapper,
  });

  Future<void> create(User user) async => firebaseFirestore
      .collection('users')
      .doc(user.id)
      .set(userMapper.toFirebase(user));

  Future<List<User>> search(String query) async => (await firebaseFirestore
          .collection('users')
          .where('last_name', isEqualTo: query)
          .get())
      .docs
      .map((snapshot) =>
          userMapper.fromFirebase(snapshot.data()).copyWith(id: snapshot.id))
      .toList(growable: false);
}
