import 'package:flutter/material.dart';

import 'package:volley_app/theme/text_styles.dart';
import 'package:volley_app/utils/team.dart';

enum IconPosition { left, right }

IconButton createIconButton(
  IconData delete, {
  required VoidCallback onPressed,
  required IconData icon,
}) {
  return IconButton(
    onPressed: onPressed,
    icon: Icon(icon),
    color: lettersColor,
  );
}

ElevatedButton createElevatedButton({
  required VoidCallback onPressed,
  required String text,
  IconData? icon,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue[800],
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      textStyle: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      side: const BorderSide(color: Colors.white, width: 2),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
        ],
        Text(text),
      ],
    ),
  );
}

DropdownButton<String> createTeamDropdown(
  String? currentValue, // Valor atual do dropdown
  String hintText, // Texto 
  List<Team> teams, // Lista de times
  String? otherTeamValue, // Valor do outro dropdown (time adversário)
  Function(String?) onChanged, // Função chamada ao mudar a seleção
) {
  return DropdownButton<String>(
    value: currentValue,
    hint: Text(hintText),
    items: teams.where((team) => team.name != otherTeamValue).map((team) {
      return DropdownMenuItem<String>(
        value: team.name,
        child: Text(team.name),
      );
    }).toList(),
    onChanged: onChanged,
    style: const TextStyle(color: lettersColor2, fontSize: 20),
  );
}

class FunctionButtons extends StatelessWidget {
  final IconData icon;
  final String text;
  final IconPosition iconPosition;
  final VoidCallback? onPressed;

  const FunctionButtons({
    super.key,
    required this.icon,
    required this.text,
    this.iconPosition = IconPosition.left,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (iconPosition == IconPosition.left) ...[
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
              padding: const EdgeInsets.all(10),
              shape: const CircleBorder(),
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
        ],
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (iconPosition == IconPosition.right) ...[
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
              padding: const EdgeInsets.all(10),
              shape: const CircleBorder(),
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ],
      ],
    );
  }
}
