import 'package:flutter/material.dart';

class AgendamentoPage extends StatelessWidget {
  AgendamentoPage({Key? key}) : super(key: key);

  final dropValue1 = ValueNotifier('');
  final dropValue2 = ValueNotifier('');
  final dropValue3 = ValueNotifier('');
  final dropValue4 = ValueNotifier('');

  final dropOpcoesBeneficiario = ['Beneficiário 1', 'Beneficiário 2', 'Beneficiário 3'];
  final dropOpcoesEspecialidade = ['Psicologia', 'Psiquiatria'];
  final dropOpcoesModalidade = ['Presencial', 'Online'];
  final dropOpcoesProfissional = ['Profissional 1', 'Profissional 2', 'Profissional 3'];

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
                Container(
                  width: 331.0,
                  height: 487.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded( // Para ocupar todo o espaço disponível
                        child: ValueListenableBuilder<String>(
                          valueListenable: dropValue1,
                          builder: (BuildContext context, String value, _) {
                            return DropdownButtonFormField<String>(
                              isExpanded: true,
                              icon: const Icon(Icons.account_circle),
                              hint: const Text('Beneficiário'),
                              decoration: InputDecoration(
                                labelText: 'Beneficiário',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) => dropValue1.value = escolha.toString(),
                              items: dropOpcoesBeneficiario.map((op) => DropdownMenuItem(
                                value: op,
                                child: Text(op),
                              )).toList(),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Expanded(
                        child: ValueListenableBuilder<String>(
                          valueListenable: dropValue2,
                          builder: (BuildContext context, String value, _) {
                            return DropdownButtonFormField<String>(
                              isExpanded: true,
                              //icon: const Icon(Icons.account_circle),
                              hint: const Text('Especialidade'),
                              decoration: InputDecoration(
                                labelText: 'Especialidade',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) => dropValue2.value = escolha.toString(),
                              items: dropOpcoesEspecialidade.map((op) => DropdownMenuItem(
                                value: op,
                                child: Text(op),
                              )).toList(),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Expanded(
                        child: ValueListenableBuilder<String>(
                          valueListenable: dropValue3,
                          builder: (BuildContext context, String value, _) {
                            return DropdownButtonFormField<String>(
                              isExpanded: true,
                              //icon: const Icon(Icons.account_circle),
                              hint: const Text('Modalidade'),
                              decoration: InputDecoration(
                                labelText: 'Modalidade',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) => dropValue3.value = escolha.toString(),
                              items: dropOpcoesModalidade.map((op) => DropdownMenuItem(
                                value: op,
                                child: Text(op),
                              )).toList(),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 10.0),
                      Expanded(
                        child: ValueListenableBuilder<String>(
                          valueListenable: dropValue4,
                          builder: (BuildContext context, String value, _) {
                            return DropdownButtonFormField<String>(
                              isExpanded: true,
                              icon: const Icon(Icons.account_box_sharp),
                              hint: const Text('Profissional'),
                              decoration: InputDecoration(
                                labelText: 'Profissional',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) => dropValue4.value = escolha.toString(),
                              items: dropOpcoesProfissional.map((op) => DropdownMenuItem(
                                value: op,
                                child: Text(op),
                              )).toList(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50.0),
                ElevatedButton(
                  onPressed: () {
                    // Abrir o popup ao clicar no botão "Próximo"
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Dados Selecionados'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Beneficiário: ${dropValue1.value}'),
                              Text('Especialidade: ${dropValue2.value}'),
                              Text('Modalidade: ${dropValue3.value}'),
                              Text('Profissional: ${dropValue4.value}'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Lógica para confirmar
                                Navigator.of(context).pop(); // Fechar o popup

                              },
                              child: Text('Confirmar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    'Próximo',
                    style: TextStyle(fontSize: 17.0),
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


