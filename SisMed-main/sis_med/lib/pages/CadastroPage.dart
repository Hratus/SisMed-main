import 'package:flutter/material.dart';
import 'login.dart';

class CadastroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB9CCF2),
      body: Stack(
        children: [
          Positioned(
            left: -60,
            top: 650,
            child: CustomPaint(
              size: Size(300, 300),
              painter: EllipsePainter(color: Color.fromRGBO(10, 72, 233, 0.42)),
            ),
          ),
          Positioned(
            left: 206.02,
            top: -116,
            child: CustomPaint(
              size: Size(300, 300),
              painter: EllipsePainter(color: Color.fromRGBO(10, 72, 233, 0.42)),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 75.0),
                    Text(
                      'Cadastro',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Define a cor do título
                        fontFamily: 'MinhaFonte', // Usa a fonte personalizada
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      labelText: 'Nome completo',
                      icon: Icons.person,
                    ),
                    CustomTextField(
                      labelText: 'Email',
                      icon: Icons.email,
                    ),
                    CustomTextField(
                      labelText: 'CPF',
                      icon: Icons.assignment_ind,
                    ),
                    CustomTextField(
                      labelText: 'Número de celular',
                      icon: Icons.phone,
                    ),
                    CustomTextField(
                      labelText: 'Senha',
                      icon: Icons.lock,
                      obscureText: true,
                    ),
                    CustomTextField(
                      labelText: 'Confirmar senha',
                      icon: Icons.lock_outline,
                      obscureText: true,
                    ),
                    CustomTextField(
                      labelText: 'Data de nascimento',
                      icon: Icons.calendar_today,
                    ),
                    CustomTextField(
                      labelText: 'Estado',
                      icon: Icons.location_on,
                    ),
                    CustomTextField(
                      labelText: 'Cidade',
                      icon: Icons.location_city,
                    ),
                    CustomTextField(
                      labelText: 'Plano de saúde',
                      icon: Icons.local_hospital,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Adicionar lógica de cadastro aqui
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        minimumSize: Size(double.infinity, 50.0),
                      ),
                      child: Text('Cadastrar'),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Já possui cadastro?'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                          child: Text(
                            'Faça Login',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final bool obscureText;

  CustomTextField({required this.labelText, required this.icon, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
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
