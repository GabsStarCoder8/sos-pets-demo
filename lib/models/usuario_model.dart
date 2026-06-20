class UsuarioModel {
  String uid;
  String nome;
  String sobrenome;
  String email;
  DateTime dataCriacao;

  UsuarioModel({
    required this.uid,
    required this.nome,
    required this.sobrenome,
    required this.email,
    required this.dataCriacao,
  });

  // Transforma o objeto do Flutter em um "Mapa" para salvar no Firebase
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nome': nome,
      'sobrenome': sobrenome,
      'email': email,
      'data_criacao': dataCriacao.toIso8601String(),
    };
  }
}
