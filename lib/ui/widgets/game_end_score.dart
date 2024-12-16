import 'package:flutter/material.dart';
import 'package:volley_app/theme/text_styles.dart';

class EndGameScore extends StatelessWidget {
  final String teamName;
  final int aceScore;
  final int attackScore;
  final int blockScore;
  final int errorScore;
  final int finalScore;

  const EndGameScore({
    super.key,
    required this.teamName,
    required this.aceScore,
    required this.attackScore,
    required this.blockScore,
    required this.errorScore,
    required this.finalScore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          teamName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Container(
          color: Colors.black45,
          height: 1.5,
          width: 50,
        ),
        Text('Ace: $aceScore', style: fontSizeStatic),
        Text('Ataque: $attackScore', style: fontSizeStatic),
        Text('Bloqueio: $blockScore', style: fontSizeStatic),
        Text('Erro: $errorScore', style: fontSizeStatic),
        Text('Set Ponto: $finalScore', style: fontSizeStatic),
      ],
    );
  }
}
