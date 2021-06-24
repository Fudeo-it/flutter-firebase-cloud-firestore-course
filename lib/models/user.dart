import 'package:telegram_app/models/model.dart';

class User extends Model {
  final String firstName;
  final String lastName;
  final DateTime? lastAccess;

  User({
    String? id,
    required this.firstName,
    required this.lastName,
    required this.lastAccess,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  @override
  List<Object?> get props => [
        ...super.props,
        firstName,
        lastName,
        lastAccess,
      ];
}
