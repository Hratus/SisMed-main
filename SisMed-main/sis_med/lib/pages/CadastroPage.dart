import 'package:flutter/material.dart';
import 'package:sis_med/models/cadastro.dart';
import 'login.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'dart:io';

class CadastroPage extends StatelessWidget {


TextEditingController fullNameInputController = TextEditingController();
TextEditingController emailInputController = TextEditingController();
TextEditingController cpfInputController = TextEditingController();
TextEditingController telefoneInoutController = TextEditingController();
TextEditingController senhaIputController = TextEditingController();
TextEditingController dataNascInputController = TextEditingController();
TextEditingController cidadeInputController = TextEditingController();
TextEditingController estadoInputController =TextEditingController();
TextEditingController planoDeSaudeInputController = TextEditingController();



///mudar tudo para FORMS



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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 75.0),
                    const Text(
                      'Cadastro',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54, // Define a cor do título
                        fontFamily: 'MinhaFonte', // Usa a fonte personalizada
                      )
                    ),


                    const SizedBox(height: 20),
                   TextFormField(
                     controller: fullNameInputController,
                     autofocus: true,
                     decoration:  const InputDecoration(
                       labelText: "Nome Completo",
                       labelStyle: TextStyle(
                         color: Colors.white
                       ),
                       prefixIcon: Icon(Icons.person)
                     )
                   ),


                    TextFormField(
                      controller: emailInputController ,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: Colors.white
                      ),
                        prefixIcon: Icon(Icons.mail_sharp)
                    )
                    ),


                    TextFormField(
                      controller: cpfInputController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: "Cpf",
                        labelStyle: TextStyle(
                          color: Colors.white
                        ),
                          prefixIcon: Icon(Icons.assignment_ind)
                      )
                    ),


                    TextFormField(
                      controller: telefoneInoutController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: "Telefone",
                        labelStyle: TextStyle(
                          color: Colors.white
                        ),
                        prefixIcon:  Icon(Icons.phone)

                      )
                    ),
                   

                   TextFormField(controller: senhaIputController,
                     autofocus: true,
                     //obscureText: true,
                     decoration: const InputDecoration(
                       labelText: "Senha",
                       labelStyle: TextStyle(
                         color: Colors.white
                       ),
                         prefixIcon: Icon(Icons.lock)
                     )

                   ),
                    
                    
                    TextFormField(controller: senhaIputController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: "Confirme sua Senha",
                        labelStyle: TextStyle(
                          color: Colors.white
                        ),
                        prefixIcon: Icon(Icons.lock)
                      )

                    ),

                    TextFormField(controller: dataNascInputController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: "Data de Nascimento",
                        labelStyle: TextStyle(
                          color: Colors.white
                        ),
                        prefixIcon: Icon(Icons.calendar_month)

                      )

                    ),
                    TextFormField(controller: estadoInputController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: "estado",
                        labelStyle: TextStyle(
                          color: Colors.white
                        ),
                        prefixIcon: Icon(Icons.location_on_rounded)
                      )

                    ),


                    TextFormField(controller: cidadeInputController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: "Cidade",
                        labelStyle: TextStyle(
                          color: Colors.white
                        ),
                        prefixIcon: Icon(Icons.location_city)
                      )
                    ),

                    TextFormField(controller: planoDeSaudeInputController,
                    autofocus: true,
                      decoration: const InputDecoration(
                        labelText: "Plano de Saude",
                        labelStyle: TextStyle(
                          color: Colors.white
                        ),
                        prefixIcon: Icon(Icons.location_city)
                      )
                    ),




                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Adicionar lógica de cadastro aqui
                        doSignUp();

                      },



                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        minimumSize: const Size(double.infinity, 50.0),
                      ),
                      child: const Text('Cadastrar'),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Já possui cadastro?'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                          child:  const Text(
                            'Faça Login',
                            style:  TextStyle(color: Colors.red),
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
  void doSignUp(){
        Cadastro newCadastro = Cadastro(nomeCompleto: fullNameInputController.text,
          email: emailInputController.text,
          cpf: cpfInputController.text,
          telefone: telefoneInoutController.text,
          senha: senhaIputController.text,
          dataNascimento: dataNascInputController.text,
          cidade: cidadeInputController.text,
          estado: estadoInputController.text,
          planoDeSaude: planoDeSaudeInputController.text,
        );
        print(newCadastro);
  }
}




class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final bool obscureText;

  const CustomTextField({super.key, required this.labelText, required this.icon, this.obscureText = false});

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

  void doSaveDataCadastro() async{
    var parseObject = ParseObject("Cadastro")
      ..set("nomeCompleto", "" )
      ..set("email", "")
      ..set("cpf", "")
      ..set("telefone", "")
      ..set("senha", "")
      ..set("dataNascimento", "")
      ..set("cidade", "")
      ..set("estado", "")
      ..set("planoDeSaude", "");

    final ParseResponse parseResponse = await parseObject.save();



  }

  void doReadDataCadastro() async{

  }

  void doUpdateDataCadastro() async{

  }
}
