import 'dart:math';

import 'package:simple_admin/features/domain/entities/influencer.dart';

class InfluencerModel extends Influencer {
  InfluencerModel({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    required String avatar,
    required String location,
    required String role,
  }) : super(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          avatar: avatar,
          location: location,
          role: role,
        );

  factory InfluencerModel.fromJson(Map<String, dynamic> json) {
    Random random = Random();
    final List<String> location = [
      'Jakarta',
      'Bandung',
      'Surabaya',
      'Makassar',
      'Medan',
      'Bali',
      'Papua',
      'Aceh',
      'Solo',
      'Yogyakarta'
    ];
    final List<String> roles = [
      'food',
      'travel',
      'marketing',
      'backoffice',
      'engineer',
      'education',
      'human resource',
    ];

    return InfluencerModel(
      id: json['id'].toString(),
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
      location: location[random.nextInt(location.length)],
      role: roles[random.nextInt(roles.length)],
    );
  }
}
