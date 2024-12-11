import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:volley_app/utils/score_provider.dart';

class TeamSide extends StatelessWidget {
  final String teamName;
  final String teamSide;

  const TeamSide({
    super.key,
    required this.teamName,
    required this.teamSide,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ScoreProvider>(
      builder: (context, scoreProvider, child) {
        final teamScore = teamSide == 'A'
            ? scoreProvider.teamAScore
            : scoreProvider.teamBScore;
        final setScore =
            teamSide == 'A' ? scoreProvider.setAScore : scoreProvider.setBScore;

        return Column(
          children: [
            const SizedBox(height: 20),
            Text(
              teamName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 60,
                vertical: 25,
              ),
              decoration: BoxDecoration(
                color: Colors.blue[800],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Text(
                '$teamScore',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text('Set Point'),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '$setScore',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
