import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/pet_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> salvarPet(PetModel pet) async {
    try {
      User? usuarioAtual = _auth.currentUser;

      if (usuarioAtual != null) {
        pet.idDono = usuarioAtual.uid;

        DocumentReference docRef = _firestore.collection('pets').doc();

        pet.idPet = docRef.id;

        await docRef.set(pet.toMap());

        return null; // Sucesso, nenhum erro!
      } else {
        return 'Usuário não está logado.';
      }
    } catch (e) {
      return 'Erro ao salvar o pet: $e';
    }
  }
}
