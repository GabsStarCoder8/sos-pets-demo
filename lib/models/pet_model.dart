class PetModel {
  String idPet;
  String idDono;
  String nomeAnimal;
  String especie;
  String dataNascimento;
  String descricao;

  PetModel({
    required this.idPet,
    required this.idDono,
    required this.nomeAnimal,
    required this.especie,
    required this.dataNascimento,
    required this.descricao,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_pet': idPet,
      'id_dono': idDono,
      'nome_animal': nomeAnimal,
      'especie': especie,
      'data_nascimento': dataNascimento,
      'descricao': descricao,
    };
  }
}
