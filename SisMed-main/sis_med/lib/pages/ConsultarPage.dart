import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

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








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar Agendamentos'),
      ),
      body: ListView.builder(
        itemCount: agendamentos.length,
        itemBuilder: (context, index) {
          final agendamento = agendamentos[index];
          final especialidade = agendamento.get<String>('especialidade') ?? '';
          final modalidade = agendamento.get<String>('modalidade') ?? '';
          final profissional = agendamento.get<String>('medico') ?? '';
          final data = agendamento.get<String>('data') ?? '';


          return ListTile(
            title: Text('Especialidade: $especialidade'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Modalidade: $modalidade'),
                Text('Medico: $profissional'),
                Text('Data: $data'),
              ],
            ),
          );
        },
      ),
    );
  }


}

