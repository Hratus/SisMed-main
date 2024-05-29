import 'package:flutter/material.dart';
import 'AgendamentoPage.dart';
import 'ConsultarPage.dart'; // Importe a página de consulta aqui
import 'ConsultarCancelamentoPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB9CCF2),
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
              painter: EllipsePainter(color:  const Color.fromRGBO(10, 72, 233, 0.42)),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Text(
                    'Olá, \n Fulano da Silva',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  width: 331.0,
                  height: 487.0,
                  decoration: BoxDecoration(
                    color: const Color(0x6FD9D9D9),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 70.0),
                      ElevatedButton(
                        onPressed: () {
                          // Navegar para tela de Agendamento
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AgendamentoPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'Novo Agendamento',
                          style: TextStyle(color: Colors.black, fontSize: 17.0),
                        ),
                      ),
                      const SizedBox(height: 60.0),
                      ElevatedButton(
                        onPressed: () {
                          // Navegar para tela de Consulta
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ConsultarPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'Consultar Agendamento',
                          style: TextStyle(color: Colors.black, fontSize: 17.0),
                        ),
                      ),
                      const SizedBox(height: 60.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ConsultarCancelamentoPage()),
                          );
                          // Lógica para adicionar agendamento
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'Consultar Cancelamentos',
                          style: TextStyle(color: Colors.black, fontSize: 17.0),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
                const SizedBox(height: 50.0),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para sair
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                      'Sair',
                      style: TextStyle(fontSize: 17.0)
                  ),
                ),
              ],
            ),
          ),
        ],
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
