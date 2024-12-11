import 'dart:async';

import 'package:flutter/material.dart';

class ScoreProvider with ChangeNotifier {
  int _teamAScore = 0;
  int _teamBScore = 0;
  int setAScore = 0;
  int setBScore = 0;
  String _winner = '';
  String _setWinner = '';
  List<List<int>> setScores = [];

  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  String _elapsedTime = '00:00';
  List<Duration> _setDurations = [];

  int get teamAScore => _teamAScore;
  int get teamBScore => _teamBScore;
  String get winner => _winner;
  String get setWinner => _setWinner;
  String get elapsedTime => _elapsedTime;
  List<Duration> get setDurations => _setDurations;

  void incrementTeamAScore() {
    _teamAScore++;
    _checkWinner();
    notifyListeners();
  }

  void incrementTeamBScore() {
    _teamBScore++;
    _checkWinner();
    notifyListeners();
  }

  void startStopwatch() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsedTime = formatTime(_stopwatch.elapsed);
      notifyListeners();
    });
  }

  void stopStopwatch() {
    _stopwatch.stop();
    _timer?.cancel();
    notifyListeners();
  }

  void resetStopwatch() {
    _stopwatch.reset();
    _elapsedTime = '00:00';
    _setDurations = [];
    notifyListeners();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void _checkWinner() {
    if (_teamAScore >= 25 && _teamAScore - _teamBScore >= 2) {
      setScores.add([_teamAScore, _teamBScore]);
      _setDurations.add(_stopwatch.elapsed);
      setAScore++;
      _setWinner = 'Team A';
      _teamAScore = 0;
      _teamBScore = 0;
    } else if (_teamBScore >= 25 && _teamBScore - _teamAScore >= 2) {
      setScores.add([_teamAScore, _teamBScore]);
      _setDurations.add(_stopwatch.elapsed);
      setBScore++;
      _setWinner = 'Team B';
      _teamAScore = 0;
      _teamBScore = 0;
    }
  }

  void resetScores() {
    _teamAScore = 0;
    _teamBScore = 0;
    _winner = '';
    _setWinner = '';
    setAScore = 0;
    setBScore = 0;
    setScores = [];
    resetStopwatch();
    _setDurations = [];
    notifyListeners();
  }

  void resetSetWinner() {
    _setWinner = '';
    notifyListeners();
  }
}
