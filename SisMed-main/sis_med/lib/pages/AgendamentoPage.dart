import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importação necessária para usar DateFormat
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AgendamentoPage extends StatefulWidget {
  @override
  _AgendamentoPageState createState() => _AgendamentoPageState();
}



class _AgendamentoPageState extends State<AgendamentoPage> {
  final dropValue2 = ValueNotifier('');
  final dropValue3 = ValueNotifier('');
  final dropValue4 = ValueNotifier('');
  final dateController = TextEditingController(); // Controlador para o campo de data

  final dropOpcoesEspecialidade = ['Psicologia', 'Psiquiatria'];
  final dropOpcoesModalidade = ['Presencial', 'Online'];
  List<String> dropOpcoesProfissional = [];

  @override
  void initState() {
    super.initState();
    _fetchProfissionais();
  }

  Future<void> _fetchProfissionais() async {
    final ParseResponse apiResponse = await ParseObject('Medico').getAll();
    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        dropOpcoesProfissional = apiResponse.results!
            .map<String>((e) => e.get<String>('nomeCompleto') ?? '')
            .where((nome) => nome.isNotEmpty)
            .toSet()
            .toList();
      });
    }
  }



  Future<void> _agendar() async {




    final agendamento = ParseObject('Agendamento')
      ..set('especialidade', dropValue2.value)
      ..set('modalidade', dropValue3.value)
      ..set('medico', dropValue4.value)
      ..set('data', dateController.text);



    final ParseResponse response = await agendamento.save();

    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Agendamento realizado com sucesso!'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao realizar o agendamento: ${response.error?.message}'),
      ));
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  /// ----> mesma coisaaa



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
                  height: 500.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10.0),
                      Expanded(
                        child: ValueListenableBuilder<String>(
                          valueListenable: dropValue2,
                          builder: (BuildContext context, String value, _) {
                            return DropdownButtonFormField<String>(
                              isExpanded: true,
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
                      const SizedBox(height: 10.0),
                      Expanded(
                        child: ValueListenableBuilder<String>(
                          valueListenable: dropValue3,
                          builder: (BuildContext context, String value, _) {
                            return DropdownButtonFormField<String>(
                              isExpanded: true,
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
                      const SizedBox(height: 10.0),
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
                      const SizedBox(height: 10.0),
                      Expanded(
                        child: TextFormField(
                          controller: dateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Data da Consulta',
                            prefixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onTap: () => _selectDate(context),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50.0),
                ElevatedButton(
                  onPressed: () {
                    _agendar();
                    Navigator.pushNamed(context, '/consultar');
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
