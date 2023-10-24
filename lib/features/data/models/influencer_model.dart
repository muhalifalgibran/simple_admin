import 'dart:math';

import 'package:simple_admin/features/domain/entities/influencer.dart';

class InfluencerModel extends Influencer {
  const InfluencerModel({
    required int page,
    required int perPage,
    required int total,
    required int totalPages,
    required List<InfluencerDataModel> data,
  }) : super(
          page: page,
          perPage: perPage,
          total: total,
          totalPages: totalPages,
          data: data,
        );

  factory InfluencerModel.fromJson(Map<String, dynamic> json) =>
      InfluencerModel(
        page: json['page'],
        perPage: json['per_page'],
        total: json['total'],
        totalPages: json['total_pages'],
        data: json['data']
            .map<InfluencerDataModel>((j) => InfluencerDataModel.fromJson(j))
            .toList(),
      );
}

class InfluencerDataModel extends InfluencerData {
  InfluencerDataModel({
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
  factory InfluencerDataModel.fromJson(Map<String, dynamic> json) {
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

    return InfluencerDataModel(
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
