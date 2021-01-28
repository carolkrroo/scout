import 'dart:io';

class Athlete {
  String athleteId;
  String name;
  String lastName;
  File image;
  String imageUrl;
  String position;
  String teamId;
  String gender;

  Athlete({
    this.athleteId,
    this.name,
    this.lastName,
    this.image,
    this.imageUrl,
    this.position,
    this.teamId,
    this.gender,
  });
}
