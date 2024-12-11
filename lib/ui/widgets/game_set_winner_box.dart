import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:volley_app/theme/text_styles.dart';
import 'package:volley_app/ui/pages/game_victory_screen.dart';
import 'package:volley_app/ui/widgets/game_function_buttons.dart';
import 'package:volley_app/utils/score_provider.dart';

class SetWinnerBox extends StatelessWidget {
  final String teamOneName;
  final String teamTwoName;
  final Map<String, int> teamAStats;
  final Map<String, int> teamBStats;

  const SetWinnerBox({
    super.key,
    required this.teamOneName,
    required this.teamTwoName,
    required this.teamAStats,
    required this.teamBStats,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(60),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<ScoreProvider>(
              builder: (context, scoreProvider, _) {
                String winnerName = scoreProvider.setWinner == 'Team A'
                    ? teamOneName
                    : teamTwoName;
                return Text(
                  '$winnerName venceu o set!',
                  style: const TextStyle(
                    color: lettersColor2,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            const SizedBox(height: 120),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                createElevatedButton(
                  onPressed: () {
                    Provider.of<ScoreProvider>(context, listen: false)
                        .resetSetWinner();
                  },
                  text: 'Novo Set',
                ),
                const SizedBox(width: 40),
                createElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
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
                  text: 'Terminar',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
