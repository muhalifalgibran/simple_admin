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

  // since we don't have specific column to be filtered
  // so, we add two colomn and choose its value randomly.
  // so, whenever our app is reload or call the model again
  // the value won't remains the same since it randomly picked
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
      'Food',
      'Travel',
      'Marketing',
      'Backoffice',
      'Engineer',
      'Education',
      'Human Resource',
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
