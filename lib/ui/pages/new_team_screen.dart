import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:volley_app/ui/widgets/game_function_buttons.dart';
import 'package:volley_app/utils/team.dart';
import 'package:volley_app/utils/team_provider.dart';

class NewTeam extends StatefulWidget {
  final VoidCallback? onPressed;
  const NewTeam({super.key, this.onPressed});

  @override
  State<NewTeam> createState() => _NewTeamState();
}

class _NewTeamState extends State<NewTeam> {
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _numberOfPlayersController =
      TextEditingController();

  @override
  void dispose() {
    _teamNameController.dispose();
    _numberOfPlayersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _teamNameController,
                      decoration: InputDecoration(
                        hintText: 'Nome',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _numberOfPlayersController,
                      decoration: InputDecoration(
                        hintText: 'N° Jogadores',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20),
                    createElevatedButton(
                      onPressed: () {
                        final String name = _teamNameController.text;
                        final int? numberOfPlayers =
                            int.tryParse(_numberOfPlayersController.text);

                        if (name.isNotEmpty && numberOfPlayers != null) {
                          final newTeam = Team(
                            name: name,
                            numberOfPlayers: numberOfPlayers,
                          );

                          Provider.of<TeamProvider>(context, listen: false)
                              .addTeam(newTeam);

                          Navigator.pop(context);
                        }
                      },
                      text: 'Inserir',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
