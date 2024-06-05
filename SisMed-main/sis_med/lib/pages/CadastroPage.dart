import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';


class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _dobController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _healthPlanController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dobController.text = DateFormat('dd/MM/yy').format(picked);
      });
    }
  }



  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dobController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _healthPlanController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      final nomeCompleto = _usernameController.text.trim();
      final email = _emailController.text.trim();
      final cpf = _cpfController.text.trim();
      final telefone = _phoneController.text.trim();
      final senha = _passwordController.text.trim();
      final dataNascimento = _dobController.text.trim();
      final estado = _stateController.text.trim();
      final cidade = _cityController.text.trim();
      final planoDeSaude = _healthPlanController.text.trim();

      final cadastro = ParseObject("Cadastro")
        ..set('nomeCompleto', nomeCompleto)
        ..set('email', email)
        ..set('cpf', cpf)
        ..set('telefone', telefone)
        ..set('dataNascimento', dataNascimento)
        ..set('estado', estado)
        ..set('cidade', cidade)
        ..set('planoDeSaude', planoDeSaude);

      // Salva o objeto no Parse Server

      var response = await cadastro.save();

      final birthday = DateFormat('dd/MM/yyyy').parse(dataNascimento);
      final age = DateTime.now().difference(birthday).inDays / 365;

      // Verifica se a idade é menor que 18 anos
      if (age < 18) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Você deve ter mais de 18 anos para se cadastrar.'),
          ),
        );
        return; // Interrompe o processo de registro
      }



      if(response.success) {
        final paciente = ParseObject("Paciente")
          ..set('nomeCompleto', nomeCompleto)..set('cpf', cpf);

        var responsePaciente = await paciente.save();


        if (responsePaciente.success) {
          // Obter o objectId do Paciente salvo
          final pacienteObjectId = paciente.objectId;

          // Criação do objeto Login com ponteiro para Paciente

          final login = ParseObject("Login")
            ..set('cpf', cpf)..set('senha', senha)..set(
                'paciente', ParseObject("Paciente")
              ..objectId = pacienteObjectId);

          var responseLogin = await login.save();

          if (responseLogin.success) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Cadastro realizado com sucesso!')));
          }

        }
      }





    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _usernameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')), // Permite apenas letras
                  ],
                  decoration: InputDecoration(labelText: 'Nome Completo', prefixIcon: Icon(Icons.person)),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Por favor, insira seu nome completo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email)),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Por favor, insira seu email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cpfController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Cpf', prefixIcon: Icon(Icons.badge)),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Por favor, insira seu CPF';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Telefone', prefixIcon: Icon(Icons.phone)),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Por favor, insira seu telefone';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Senha', prefixIcon: Icon(Icons.lock)),
                  obscureText: true,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Por favor, insira sua senha';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(labelText: 'Confirme sua Senha', prefixIcon: Icon(Icons.lock)),
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'As senhas não coincidem';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dobController,
                  decoration: InputDecoration(labelText: 'Data de Nascimento', prefixIcon: Icon(Icons.calendar_today)
                  ),readOnly: true,
                  onTap: () => _selectDate(context),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Por favor, insira sua data de nascimento';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _stateController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')), // Permite apenas letras
                  ],
                  decoration: InputDecoration(labelText: 'Estado', prefixIcon: Icon(Icons.map)),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Por favor, insira seu estado';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cityController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')), // Permite apenas letras
                  ],
                  decoration: InputDecoration(labelText: 'Cidade', prefixIcon: Icon(Icons.location_city)),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Por favor, insira sua cidade';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _healthPlanController,
                  decoration: InputDecoration(labelText: 'Plano de Saúde', prefixIcon: Icon(Icons.local_hospital)),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Por favor, insira seu plano de saúde';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
                  child: Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}