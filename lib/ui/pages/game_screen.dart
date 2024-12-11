import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:volley_app/theme/text_styles.dart';
import 'package:volley_app/ui/pages/game_result_screen.dart';
import 'package:volley_app/ui/widgets/game_function_buttons.dart';
import 'package:volley_app/ui/widgets/game_set_winner_box.dart';
import 'package:volley_app/utils/score_provider.dart';

import '../widgets/game_team_side.dart';

class GameZone extends StatefulWidget {
  final String teamOneName;
  final String teamTwoName;

  const GameZone({
    super.key,
    required this.teamOneName,
    required this.teamTwoName,
  });

  @override
  State<GameZone> createState() => _GameZoneState();
}

class _GameZoneState extends State<GameZone> {
  String _elapsedTime = '00:00';
  int teamAAces = 0;
  int teamAAttacks = 0;
  int teamABlocks = 0;
  int teamAErrors = 0;

  int teamBAces = 0;
  int teamBAttacks = 0;
  int teamBBlocks = 0;
  int teamBErrors = 0;

  bool _showBox = false;
  Timer? _timer;
  final Stopwatch _stopwatch = Stopwatch();

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
    Provider.of<ScoreProvider>(context, listen: false).stopStopwatch();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {});
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    Provider.of<ScoreProvider>(context, listen: false).startStopwatch();
    _startTimer();
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void _startTimer() {
    _stopwatch.start();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => _elapsedTime = _formatTime(_stopwatch.elapsed));
      });
    });
  }

  void _navigateToVictoryScreen(BuildContext context) {
    final scoreProvider = Provider.of<ScoreProvider>(context, listen: false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultGame(
          teamOneName: widget.teamOneName,
          teamTwoName: widget.teamTwoName,
          winner: scoreProvider.setWinner,
          teamAStats: {
            'ace': teamAAces,
            'attack': teamAAttacks,
            'block': teamABlocks,
            'error': teamAErrors,
            'final': scoreProvider.setAScore,
          },
          teamBStats: {
            'ace': teamBAces,
            'attack': teamBAttacks,
            'block': teamBBlocks,
            'error': teamBErrors,
            'final': scoreProvider.setBScore,
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundScreenColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Consumer<ScoreProvider>(
            builder: (context, scoreProvider, child) {
              if (scoreProvider.setWinner.isNotEmpty && !_showBox) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() => _showBox = true);
                });
              }
              return Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                              scoreProvider.resetScores();
                            },
                          ),
                          FunctionButtons(
                            icon: Icons.add,
                            text: 'Ace',
                            onPressed: scoreProvider.setWinner.isEmpty
                                ? () {
                                    scoreProvider.incrementTeamAScore();
                                    teamAAces++;
                                  }
                                : null,
                          ),
                          FunctionButtons(
                            icon: Icons.add,
                            text: 'Attack',
                            onPressed: scoreProvider.setWinner.isEmpty
                                ? () {
                                    scoreProvider.incrementTeamAScore();
                                    teamAAttacks++;
                                  }
                                : null,
                          ),
                          FunctionButtons(
                            icon: Icons.add,
                            text: 'Block',
                            onPressed: scoreProvider.setWinner.isEmpty
                                ? () {
                                    scoreProvider.incrementTeamAScore();
                                    teamABlocks++;
                                  }
                                : null,
                          ),
                          FunctionButtons(
                            icon: Icons.add,
                            text: 'Error',
                            onPressed: scoreProvider.setWinner.isEmpty
                                ? () {
                                    scoreProvider.incrementTeamAScore();
                                    teamAErrors++;
                                  }
                                : null,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(
                            width: screenWidth * 0.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TeamSide(
                                  teamName: widget.teamOneName,
                                  teamSide: 'A',
                                ),
                                TeamSide(
                                  teamName: widget.teamTwoName,
                                  teamSide: 'B',
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _elapsedTime,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          createElevatedButton(
                            onPressed: () {
                              _navigateToVictoryScreen(context);
                            },
                            text: 'Placar Geral',
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.settings),
                          ),
                          FunctionButtons(
                            icon: Icons.add,
                            iconPosition: IconPosition.right,
                            text: 'Ace',
                            onPressed: scoreProvider.setWinner.isEmpty
                                ? () {
                                    scoreProvider.incrementTeamBScore();
                                    teamBAces++;
                                  }
                                : null,
                          ),
                          FunctionButtons(
                            icon: Icons.add,
                            iconPosition: IconPosition.right,
                            text: 'Attack',
                            onPressed: scoreProvider.setWinner.isEmpty
                                ? () {
                                    scoreProvider.incrementTeamBScore();
                                    teamBAttacks++;
                                  }
                                : null,
                          ),
                          FunctionButtons(
                            icon: Icons.add,
                            iconPosition: IconPosition.right,
                            text: 'Block',
                            onPressed: scoreProvider.setWinner.isEmpty
                                ? () {
                                    scoreProvider.incrementTeamBScore();
                                    teamBBlocks++;
                                  }
                                : null,
                          ),
                          FunctionButtons(
                            icon: Icons.add,
                            iconPosition: IconPosition.right,
                            text: 'Error',
                            onPressed: scoreProvider.setWinner.isEmpty
                                ? () {
                                    scoreProvider.incrementTeamBScore();
                                    teamBErrors++;
                                  }
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (scoreProvider.setWinner.isNotEmpty)
                    SetWinnerBox(
                      teamOneName: widget.teamOneName,
                      teamTwoName: widget.teamTwoName,
                      teamAStats: {
                        'ace': teamAAces,
                        'attack': teamAAttacks,
                        'block': teamABlocks,
                        'error': teamAErrors,
                      },
                      teamBStats: {
                        'ace': teamBAces,
                        'attack': teamBAttacks,
                        'block': teamBBlocks,
                        'error': teamBErrors,
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
