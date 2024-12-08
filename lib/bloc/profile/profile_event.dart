part of 'profile_bloc.dart';

@immutable
class ProfileEvent {}

class GetProfileData extends ProfileEvent {}

class UpdateProfile extends ProfileEvent{
  String name;
  String profession;
  String description;
  String photo;

  UpdateProfile(this.name, this.profession, this.description, this.photo);
}