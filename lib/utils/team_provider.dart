import 'package:flutter/material.dart';
import 'package:volley_app/utils/team.dart';

class TeamProvider extends ChangeNotifier {
  final List<Team> _teams = [];

  List<Team> get teams => _teams;

  void addTeam(Team team) {
    if (_teams.length < 6) {
      if (team.name.length <= 13) {
        if (team.numPlayers <= 12) {
          _teams.add(team);
          notifyListeners();
        } else {
          _showError("Número máximo de jogadores por time é 12.");
        }
      } else {
        _showError("O nome do time pode ter no máximo 15 caracteres.");
      }
    } else {
      _showError("Número máximo de times atingido (6).");
    }
  }

  void removeTeam(String teamName) {
    _teams.removeWhere((team) => team.name == teamName);
    notifyListeners();
  }

  void _showError(String message) {
    print("Erro: $message");
  }
}
