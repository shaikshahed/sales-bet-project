import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String id;
  String name;
  int credits;

  UserModel({required this.id, required this.name, this.credits = 1000});

  factory UserModel.sample() => UserModel(id: 'user_1', name: 'Demo User', credits: 1000);

  void addCredits(int amount) {
    credits += amount;
    notifyListeners();
  }
}
 