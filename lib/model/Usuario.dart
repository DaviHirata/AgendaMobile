class Usuario {
  int? id;
  String nome;
  String email;
  String telefone;
  String senha;
  String? foto;

  Usuario({
    this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.senha,
    this.foto,
  });

  factory Usuario.fromMap(Map<String, dynamic> json) {
    return Usuario(
      id: json['id_usuario'],
      nome: json['nome'],
      email: json['email'],
      telefone: json['telefone'],
      senha: json['senha'],
      foto: json['foto'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_usuario': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'senha': senha,
      'foto': foto,
    };
  }
}