import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/text_styles.dart';
import 'package:volley_app/utils/team_provider.dart';

class VolleyTeams extends StatelessWidget {
  final VoidCallback? onPressed;
  final String teamName;
  final int numberPlayers;
  final double screenWidth;

  const VolleyTeams({
    super.key,
    this.onPressed,
    required this.teamName,
    required this.numberPlayers,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: SizedBox(
        //height: 60,
        width: screenWidth * 0.80,
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Consumer<TeamProvider>(
              builder: (context, teamProvider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Nome do Time
                    Text(
                      teamName,
                      style: const TextStyle(
                        color: Colors.yellow,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Ícone deletar e número de jogadores
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Ícone deletar
                        IconButton(
                          onPressed: () {
                            Provider.of<TeamProvider>(context, listen: false)
                                .removeTeam(teamName);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: iconColor,
                            size: 15,
                          ),
                        ),
                        const SizedBox(width: 30),

                        // Número de jogadores
                        Row(
                          children: [
                            Text(
                              '$numberPlayers',
                              style: const TextStyle(
                                color: Color(0xFF2B4A8E),
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const RotatedBox(
                              quarterTurns: 3,
                              child: Text(
                                'jogadores',
                                style: TextStyle(
                                    color: Color(0xFF2B4A8E), fontSize: 8),
                              ),
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
      ),
    );
  }
}
