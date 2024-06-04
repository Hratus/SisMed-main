import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ConsultarPage extends StatefulWidget {
  @override
  _ConsultarPageState createState() => _ConsultarPageState();
}

class _ConsultarPageState extends State<ConsultarPage> {
  List<ParseObject> agendamentos = [];

  @override
  void initState() {
    super.initState();
    _fetchAgendamentos();
  }

  Future<void> _fetchAgendamentos() async {
    final ParseResponse apiResponse = await ParseObject('Agendamento').getAll();
    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        agendamentos = List<ParseObject>.from(apiResponse.results!);
      });
    }
  }

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
                ListView.builder(
                  itemCount: agendamentos.length,
                  itemBuilder: (context, index) {
                    final agendamento = agendamentos[index];
                    return _buildAgendamentoCard(agendamento);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgendamentoCard(ParseObject agendamento) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Paciente: ${agendamento.get<String>('paciente')}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Especialidade: ${agendamento.get<String>('especialidade')}'),
              Text('Modalidade: ${agendamento.get<String>('modalidade')}'),
              Text('Profissional: ${agendamento.get<String>('profissional')}'),
              Text('Data: ${agendamento.get<String>('data')}'),
              Text('Hora: ${agendamento.get<String>('hora')}'),
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
