import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'HomePage.dart';

class ConsultarPage extends StatefulWidget {
  @override
  _ConsultarPageState createState() => _ConsultarPageState();
}

class _ConsultarPageState extends State<ConsultarPage> {
  List<ParseObject> agendamentos = [];
  ParseObject? currentUser;

  @override
  void initState() {
    super.initState();
    _fetchAgendamentos();
  }

  Future<void> _fetchAgendamentos() async {
    final QueryBuilder<ParseObject> query = QueryBuilder<ParseObject>(ParseObject('Agendamento'))
      ..whereEqualTo('login', currentUser);
    final ParseResponse apiResponse = await query.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        agendamentos = List<ParseObject>.from(apiResponse.results!);
      });
    }
  }

  void _cancelarAgendamento(ParseObject agendamento) {
    // Implemente aqui a lógica para cancelar o agendamento
    // Isso pode envolver o envio de uma solicitação ao servidor para cancelar o agendamento
    // e atualizar a lista de agendamentos após o cancelamento
  }

  void _voltarHomePage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB9CCF2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Lista de Agendamentos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: agendamentos.length,
                itemBuilder: (context, index) {
                  final agendamento = agendamentos[index];
                  final especialidade = agendamento.get<String>('especialidade') ?? '';
                  final modalidade = agendamento.get<String>('modalidade') ?? '';
                  final profissional = agendamento.get<String>('medico') ?? '';
                  final data = agendamento.get<String>('data') ?? '';

                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.cancel),
                                  title: Text('Cancelar Agendamento'),
                                  onTap: () {
                                    _cancelarAgendamento(agendamento);
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.arrow_back),
                                  title: Text('Voltar para a Homepage'),
                                  onTap: () {
                                    _voltarHomePage();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white, // Cor de fundo dos blocos
                        borderRadius: BorderRadius.circular(10), // Borda arredondada
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Especialidade: $especialidade',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Modalidade: $modalidade',
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Medico: $profissional',
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Data: $data',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
