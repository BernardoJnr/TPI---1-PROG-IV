import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:volley_app/theme/text_styles.dart';
import 'package:volley_app/utils/team_provider.dart';

class VolleyTeams extends StatelessWidget {
  final String teamName;
  final int numberPlayers;

  const VolleyTeams({
    super.key,
    required this.teamName,
    required this.numberPlayers,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<TeamProvider>(
          builder: (context, teamProvider, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  teamName,
                  style: styleTeamName,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Provider.of<TeamProvider>(context, listen: false)
                            .removeTeam(teamName);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: lettersColor,
                        size: 15,
                      ),
                    ),
                    const SizedBox(width: 30),
                    Row(
                      children: [
                        Text('$numberPlayers', style: styleNumberPlayer),
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
    );
  }
}
