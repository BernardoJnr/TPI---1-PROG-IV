import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:volley_app/theme/text_styles.dart';
import 'package:volley_app/ui/pages/new_team_screen.dart';
import 'package:volley_app/ui/pages/team_selection_screen.dart';
import 'package:volley_app/ui/widgets/game_function_buttons.dart';
import 'package:volley_app/ui/widgets/volley_teams.dart';
import 'package:volley_app/utils/team_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundScreenColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/volleyball.png',
                    width: 50,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Text>[
                        Text(
                          'Volley',
                          style: TextStyle(
                            color: lettersColor,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        Text(
                          'do fim de semana',
                          style: TextStyle(
                            color: lettersColor,
                            fontSize: 8,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 250,
                        width: 60,
                        color: const Color.fromRGBO(110, 197, 202, 1),
                        child: const RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            'TIMES',
                            style: TextStyle(
                              color: lettersColor,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Consumer<TeamProvider>(
                        builder: (context, teamProvider, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: teamProvider.teams.map((team) {
                              return VolleyTeams(
                                teamName: team.name,
                                numberPlayers: team.numPlayers,
                                screenWidth: screenWidth,
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Jogo Casado',
                style: timerStyle,
              ),
              createElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeamVsTeam(),
                    ),
                  );
                },
                text: 'Iniciar',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewTeam()),
          );
        },
        backgroundColor: Colors.blue[800],
        child: const Icon(
          Icons.add,
          color: lettersColor,
        ),
      ),
    );
  }
}
