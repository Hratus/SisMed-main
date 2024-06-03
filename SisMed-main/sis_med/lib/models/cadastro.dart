

class Cadastro {

  String? nomeCompleto;
  String? email;
  String? cpf;
  String? telefone;
  String? senha;
  String? dataNascimento;
  String? cidade;
  String? estado;
  String? planoDeSaude;

  Cadastro({
    this.nomeCompleto,
    this.email,
    this.cpf,
    this.telefone,
    this.senha,
    this.dataNascimento,
    this.cidade,
    this.estado,
    this.planoDeSaude,
});
  Cadastro.fromJson(Map<String, dynamic> json) {
    nomeCompleto = json['nomeCompleto'];
    email = json['email'];
    cpf = json['cpf'];
    telefone = json['telefone'];
    senha = json['senha'];
    dataNascimento = json['dataNascimento'];
    estado = json['estado'];
    cidade = json['cidade'];
    planoDeSaude = json['planoDeSaude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomeCompleto'] = this.nomeCompleto;
    data['email'] = this.email;
    data['cpf'] = this.cpf;
    data['telefone'] = this.telefone;
    data['senha'] = this.senha;
    data['dataNascimento'] = this.dataNascimento;
    data['estado'] = this.estado;
    data['cidade'] = this.cidade;
    data['planoDeSaude'] = this.planoDeSaude;
    return data;
  }
}

