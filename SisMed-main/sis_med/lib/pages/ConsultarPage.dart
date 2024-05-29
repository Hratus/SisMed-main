import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConsultarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB9CCF2), // Cor de fundo igual à tela inicial
      body: Stack(
        children: [
          Positioned(
            left: -60,
            top: 650,
            child: CustomPaint(
              size: const Size(300, 300),
              painter: EllipsePainter(color: const Color.fromRGBO(10, 72, 233, 0.42)),
            ),
          ),
          Positioned(
            left: 206.02,
            top: -116,
            child: CustomPaint(
              size: const Size(300, 300),
              painter: EllipsePainter(color: const Color.fromRGBO(10, 72, 233, 0.42)),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Consultar Agendamentos',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                _buildAgendamentoCard(),
                SizedBox(height: 20),
                _buildAgendamentoCard(),
                SizedBox(height: 20),
                _buildAgendamentoCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgendamentoCard() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox( // Alteração aqui
        width: 300, // Define a largura do card como a largura máxima possível
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Paciente: Fulano de Tal',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Especialidade: Psiquiatria'),
              Text('Modalidade: Presencial'),
              Text('Profissional: Dr. João Silva'),
              Text('Data: 12/05/2024'),
              Text('Hora: 10:00'),
            ],
          ),
        ),
      ),
    );
  }
}

class EllipsePainter extends CustomPainter {
  final Color color;

  EllipsePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawOval(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}