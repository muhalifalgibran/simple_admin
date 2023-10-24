import 'package:equatable/equatable.dart';

class Influencer extends Equatable {
  final String id, email, firstName, lastName, avatar, location, role;
  bool selected = false;

  Influencer({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.location,
    required this.role,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        avatar,
        location,
        role,
      ];
}
