import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/pet_model.dart';
import '../services/firestore_service.dart';
import 'home_screen.dart';

class ReviewPetScreen extends StatefulWidget {
  final PetModel pet;

  const ReviewPetScreen({super.key, required this.pet});

  @override
  State<ReviewPetScreen> createState() => _ReviewPetScreenState();
}

class _ReviewPetScreenState extends State<ReviewPetScreen> {
  static const Color primaryColor = Color(0xFF2D6A9F);
  static const Color lightBlue = Color(0xFFABCBE5);

  bool _isLoading = false;

  void _salvarPet() async {
    setState(() {
      _isLoading = true;
    });

    String? erro = await FirestoreService().salvarPet(widget.pet);

    setState(() {
      _isLoading = false;
    });

    if (erro == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pet cadastrado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (Route<dynamic> route) => false,
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(erro), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 260,
              width: double.infinity,
              color: lightBlue,
              child: SafeArea(
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 10,
                      child: TextButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: primaryColor,
                          size: 18,
                        ),
                        label: const Text(
                          'Voltar',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: SvgPicture.asset(
                        'assets/icons/paw-big-home.svg',
                        height: 140,
                        colorFilter: ColorFilter.mode(
                          primaryColor.withOpacity(0.5),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoItem('Nome do Animal', widget.pet.nomeAnimal),
                  const SizedBox(height: 24),

                  _buildInfoItem('Especie do Animal', widget.pet.especie),
                  const SizedBox(height: 24),

                  _buildInfoItem(
                    'Data de Nascimento',
                    widget.pet.dataNascimento,
                  ),
                  const SizedBox(height: 24),

                  _buildInfoItem('Descrição', widget.pet.descricao),
                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _isLoading ? null : _salvarPet,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Avançar',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String titulo, String valorDigitado) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            color: Color(0xFF2D6A9F),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          valorDigitado,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
