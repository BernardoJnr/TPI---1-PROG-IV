import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:volley_app/ui/widgets/game_end_score.dart';
import 'package:volley_app/utils/score_provider.dart';

class VictoryGame extends StatelessWidget {
  final String teamAName;
  final String teamBName;
  final Map<String, int> teamAStats;
  final Map<String, int> teamBStats;

  const VictoryGame({
    super.key,
    required this.teamAName,
    required this.teamBName,
    required this.teamAStats,
    required this.teamBStats,
  });

  @override
  Widget build(BuildContext context) {
    final scoreProvider = Provider.of<ScoreProvider>(context, listen: false);
    Duration totalSetTime = scoreProvider.setDurations.fold(
        Duration.zero, (previousValue, element) => previousValue + element);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Text(
                  'Estatisticas Individuais',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          EndGameScore(
                            teamName: teamAName,
                            aceScore: teamAStats['ace'] ?? 0,
                            attackScore: teamAStats['attack'] ?? 0,
                            blockScore: teamAStats['block'] ?? 0,
                            errorScore: teamAStats['error'] ?? 0,
                            finalScore:
                                Provider.of<ScoreProvider>(context).setAScore,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          EndGameScore(
                            teamName: teamBName,
                            aceScore: teamBStats['ace'] ?? 0,
                            attackScore: teamBStats['attack'] ?? 0,
                            blockScore: teamBStats['block'] ?? 0,
                            errorScore: teamBStats['error'] ?? 0,
                            finalScore:
                                Provider.of<ScoreProvider>(context).setBScore,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Tempo da partida: ${scoreProvider.formatTime(totalSetTime)}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        SystemNavigator.pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[800],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const Text(
                          'Finalizar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        scoreProvider.resetScores();
                        scoreProvider.resetStopwatch();

                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitUp,
                        ]);

                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (route) => false);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[800],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const Text(
                          'Novo Jogo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
