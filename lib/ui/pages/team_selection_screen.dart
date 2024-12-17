import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:volley_app/theme/text_styles.dart';
import 'package:volley_app/ui/pages/game_screen.dart';
import 'package:volley_app/ui/widgets/game_function_buttons.dart';
import 'package:volley_app/utils/team_provider.dart';

class TeamVsTeam extends StatefulWidget {
  const TeamVsTeam({super.key});

  @override
  State<TeamVsTeam> createState() => _TeamVsTeamState();
}

class _TeamVsTeamState extends State<TeamVsTeam> {
  String? time_a;
  String? time_b;

  @override
  void dispose() {
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

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final teams = Provider.of<TeamProvider>(context).teams;

    return Scaffold(
      backgroundColor: backgroundScreenColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: lettersColor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Chamada da função para o dropdown do Time A
                          createTeamDropdown(
                            time_a,
                            'Time - A',
                            teams,
                            time_b,
                            (value) {
                              setState(() {
                                time_a = value;
                                if (time_b == value) {
                                  time_b = null;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      createElevatedButton(
                        onPressed: () {
                          if (time_a != null && time_b != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GameZone(
                                  teamOneName: time_a!,
                                  teamTwoName: time_b!,
                                ),
                              ),
                            );
                          }
                        },
                        text: 'Começar',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 48),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Chamada da função para o dropdown do Time B
                            createTeamDropdown(
                              time_b,
                              'Time - B',
                              teams,
                              time_a,
                              (value) {
                                setState(() {
                                  time_b = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
