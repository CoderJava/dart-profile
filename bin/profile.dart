import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'birth_date')
  final String? birthDate;

  Profile({
    this.id,
    this.createdAt,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.birthDate,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  @override
  String toString() {
    return 'Profile{id: $id, createdAt: $createdAt, fullName: $fullName, '
        'email: $email, phoneNumber: $phoneNumber, birthDate: $birthDate}';
  }
}
