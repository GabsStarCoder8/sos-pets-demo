import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MeusPetsScreen extends StatefulWidget {
  const MeusPetsScreen({super.key});

  @override
  State<MeusPetsScreen> createState() => _MeusPetsScreenState();
}

class _MeusPetsScreenState extends State<MeusPetsScreen> {
  static const Color primaryColor = Color(0xFF2D6A9F);
  static const Color lightBlue = Color(0xFFABCBE5);

  final String? _userId = FirebaseAuth.instance.currentUser?.uid;

  void _excluirPet(String petId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Excluir Pet?',
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Tem certeza que deseja remover este animalzinho? Esta ação não pode ser desfeita.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () async {
                Navigator.pop(context);

                await FirebaseFirestore.instance
                    .collection('pets')
                    .doc(petId)
                    .delete();

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pet removido com sucesso!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text(
                'Excluir',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: primaryColor,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Seus animais',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('pets')
                .where('id_dono', isEqualTo: _userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Erro ao buscar pets.'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    'Você ainda não tem animais cadastrados.',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              }

              final pets = snapshot.data!.docs;

              return ListView.builder(
                itemCount: pets.length,
                itemBuilder: (context, index) {
                  // Pega o "documento" inteiro do Firebase
                  var petDoc = pets[index];

                  // Extrai os dados internos (Nome, descrição, etc)
                  var petData = petDoc.data() as Map<String, dynamic>;
                  String nomePet = petData['nome_animal'] ?? 'Sem nome';

                  // Pega o ID ÚNICO daquele documento no banco
                  String petId = petDoc.id;

                  // Chama a função atualizada passando as 3 coisas exatas!
                  return _buildPetCard(nomePet, petId, petData);
                },
              );
            },
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: lightBlue,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home-icon.svg',
              height: 26,
              colorFilter: const ColorFilter.mode(lightBlue, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/home-icon.svg',
              height: 26,
              colorFilter: const ColorFilter.mode(
                primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/add-dog.svg',
              height: 26,
              colorFilter: const ColorFilter.mode(lightBlue, BlendMode.srcIn),
            ),
            label: 'AddDog',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon-loc.svg',
              height: 26,
              colorFilter: const ColorFilter.mode(lightBlue, BlendMode.srcIn),
            ),
            label: 'Localização',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/send-icon.svg',
              height: 26,
              colorFilter: const ColorFilter.mode(lightBlue, BlendMode.srcIn),
            ),
            label: 'Send',
          ),
        ],
      ),
    );
  }

  Widget _buildPetCard(
    String nomePet,
    String petId,
    Map<String, dynamic> petData,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
              color: const Color(0xFFABCBE5).withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                'assets/icons/paw-icon.svg',
                colorFilter: const ColorFilter.mode(
                  Color(0xFF2D6A9F),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Text(
              nomePet,
              style: const TextStyle(
                color: Color(0xFF2D6A9F),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: Color(0xFF2D6A9F)),
                onPressed: () {
                  print('Clicou em editar o pet: $nomePet');
                },
              ),

              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () {
                  _excluirPet(petId);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
