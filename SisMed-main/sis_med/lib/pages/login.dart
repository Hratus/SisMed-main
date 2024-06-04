import 'package:flutter/material.dart';
import 'HomePage.dart';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _cpfController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      final cpf = _cpfController.text.trim();
      final password = _passwordController.text.trim();

      // Query ParseUser class with CPF and password
      final query = QueryBuilder<ParseObject>(ParseObject('Login'))
        ..whereEqualTo('cpf', cpf)
        ..whereEqualTo('senha', password);

      var response = await query.query();

      if (response.success && response.results != null && response.results!.isNotEmpty) {
        var user = response.results!.first;
        var username = user.get<String>('username');

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login realizado com sucesso!')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );

        // Navigate to HomePage or Dashboard
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('CPF ou senha inválidos!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _cpfController,
                decoration: InputDecoration(
                  labelText: 'CPF',
                  prefixIcon: Icon(Icons.badge),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, insira seu CPF';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, insira sua senha';
                  }
                  return null;
                },
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                  ),
                  Text('Remember-me'),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      // Esqueci a senha
                    },
                    child: Text('Esqueceu a senha?'),
                  ),
                ],
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: _login,
                child: Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}