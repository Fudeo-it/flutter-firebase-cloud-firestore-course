import 'package:telegram_app/misc/mappers/firebase_mapper.dart';
import 'package:telegram_app/models/user.dart';

class UserFirebaseMapper extends FirebaseMapper<User> {
  @override
  User fromFirebase(Map<String, dynamic> map) {
    // TODO: implement fromFirebase
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toFirebase(User user) => {
        'first_name': user.firstName,
        'last_name': user.lastName,
        'last_access': user.lastAccess?.millisecondsSinceEpoch,
        'created_at': user.createdAt.millisecondsSinceEpoch,
        'updated_at': user.updatedAt?.millisecondsSinceEpoch,
      };
}
