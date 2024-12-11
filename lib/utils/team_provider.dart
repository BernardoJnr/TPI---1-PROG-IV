import 'package:flutter/material.dart';
import 'package:volley_app/utils/team.dart';

class TeamProvider extends ChangeNotifier {
  final List<Team> _teams = [];

  List<Team> get teams => _teams;

  void addTeam(Team team) {
    if (_teams.length < 6) {
      _teams.add(team);
      notifyListeners();
    }
  }

  void removeTeam(String teamName) {
    _teams.removeWhere((team) => team.name == teamName);
    notifyListeners();
  }
}
