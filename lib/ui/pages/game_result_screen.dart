import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:volley_app/theme/text_styles.dart';
import 'package:volley_app/ui/pages/game_victory_screen.dart';
import 'package:volley_app/utils/score_provider.dart';

class ResultGame extends StatelessWidget {
  final String teamOneName;
  final String teamTwoName;
  final String winner;
  final Map<String, int> teamAStats;
  final Map<String, int> teamBStats;

  const ResultGame({
    super.key,
    required this.teamOneName,
    required this.teamTwoName,
    required this.winner,
    required this.teamAStats,
    required this.teamBStats,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundScreenColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Consumer<ScoreProvider>(
            builder: (context, scoreProvider, _) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const Text(
                        'PLACAR GERAL',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VictoryGame(
                                teamAName: teamOneName,
                                teamBName: teamTwoName,
                                teamAStats: teamAStats,
                                teamBStats: teamBStats,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.insights),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                                child: Column(
                                  children: [
                                    const Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 15,
                                          child: Text(
                                            'A',
                                            style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    for (int i = 0;
                                        i < scoreProvider.setScores.length;
                                        i++)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Icon(
                                              Icons.bar_chart,
                                              color: lettersColor,
                                              size: 25,
                                            ),
                                            const SizedBox(
                                              width: 25,
                                            ),
                                            Text(
                                              '${teamOneName}  ${scoreProvider.setScores[i][0]}',
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                                child: Column(
                                  children: [
                                    const Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 15,
                                          child: Text(
                                            'B',
                                            style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    for (int i = 0;
                                        i < scoreProvider.setScores.length;
                                        i++)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${scoreProvider.setScores[i][1]}  ${teamTwoName}',
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            const SizedBox(
                                              width: 25,
                                            ),
                                            Text(
                                              scoreProvider.formatTime(
                                                  scoreProvider
                                                      .setDurations[i]),
                                              style: timerStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
