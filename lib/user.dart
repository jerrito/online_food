//import 'package:firestoredatabase/operations.dart';

import 'dart:convert';

import 'package:online_food/firebase_services.dart';

class Appointment implements Serializable {
  String? date;
  String? fullname;
  String? email;
  String? image;
  int? experience;
  String? time;
  String? doctor;
  String? speciality;
  String? location;
  String? number;
  int? patients;
  double? ratings;
  Appointment(
      {this.date,
      this.image,
      this.email,
      this.experience,
      this.time,
      this.doctor,
      this.fullname,
      this.speciality,
      this.location,
      this.patients,
      this.ratings,
      this.number});

  factory Appointment.fromJson(Map? json) => Appointment(
      date: json?["date"],
      image: json?["image"],
      email: json?["email"],
      experience: json?["experience"],
      fullname: json?["fullname"],
      patients: json?["patients"],
      time: json?["time"],
      ratings: json?["ratings"],
      doctor: json?["doctor"],
      speciality: json?["speciality"],
      number: json?["number"],
      location: json?["location"]);
  @override
  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "fullname": fullname,
      "email": email,
      "experience": experience,
      "image": image,
      "patients": patients,
      "time": time,
      "ratings": ratings,
      "doctor": doctor,
      "speciality": speciality,
      "location": location,
      "number": number,
    };
  }

  static Appointment fromString(String userString) {
    return Appointment.fromJson(jsonDecode(userString));
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

// class MedicalInfo implements Serializable {
//   String? id;
//   String? number;
//   String? bloodType;
//   String? medications;
//   String? medicalNotes;
//   String? organDonor;
//   MedicalInfo(
//       {this.number,
//       this.bloodType,
//       this.medicalNotes,
//       this.medications,
//       this.organDonor,
//       this.id});
//   factory MedicalInfo.fromJson(Map? json) => MedicalInfo(
//         bloodType: json?["bloodType"],
//         number: json?["number"],
//         id: json?["id"],
//         medications: json?["medications"],
//         medicalNotes: json?["medicalNotes"],
//         organDonor: json?["organDonor"],
//       );
//
//   @override
//   Map<String, dynamic> toJson() {
//     return {
//       "bloodType": bloodType,
//       "number": number,
//       "id": id,
//       "medications": medications,
//       "medicalNotes": medicalNotes,
//       "organDonor": organDonor
//     };
//   }
//
//   static MedicalInfo fromString(String medicalInfoString) {
//     return MedicalInfo.fromJson(jsonDecode(medicalInfoString));
//   }
//
//   @override
//   String toString() {
//     return jsonEncode(toJson());
//   }
// }

class User implements Serializable {
  String? fullName;
  String? number;
  String? email;
  String? password;
  String? id;
  String? image;
  String? location;

  User({
    this.fullName,
    this.number,
    this.id,
    this.email,
    this.password,
    this.image,
    this.location,
  });
  factory User.fromJson(Map? json) => User(
        id: json?["id"],
        fullName: json?["fullname"],
        number: json?["number"],
        email: json?["email"],
        password: json?["password"],
        image: json?["image"],
        location: json?["location"],
      );
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      "fullname": fullName,
      "number": number,
      "password": password,
      "email": email,
      "image": image,
      "location": location,
    };
  }

  static User fromString(String userString) {
    return User.fromJson(jsonDecode(userString));
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
