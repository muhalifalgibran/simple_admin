import 'package:equatable/equatable.dart';

class Influencer extends Equatable {
  final int page, perPage, total, totalPages;
  final List<InfluencerData> data;

  const Influencer({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });
  @override
  List<Object?> get props => [
        page,
        perPage,
        total,
        totalPages,
        data,
      ];
}

// class Influencer
class InfluencerData extends Equatable {
  final String id, email, firstName, lastName, avatar, location, role;
  bool selected = false;

  InfluencerData({
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
