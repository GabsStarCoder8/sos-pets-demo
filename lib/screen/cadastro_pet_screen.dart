import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'review_pet_screen.dart';

class CadastroPetScreen extends StatelessWidget {
  const CadastroPetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF2D6A9F);
    const Color lightBlue = Color(0xFFABCBE5);

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
                //Botão voltar, Pata, Câmera
                child: Stack(
                  children: [
                    // Botão de Voltar
                    Positioned(
                      top: 10,
                      left: 10,
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.pop(
                            context,
                          ); // Função nativa para fechar a tela e voltar
                        },
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

                    // Ícone Central da Pata Gigante
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

                    // Ícone da Câmera
                    Positioned(
                      bottom: 15,
                      right: 15,
                      child: Icon(
                        Icons.camera_alt,
                        color: primaryColor.withOpacity(0.6),
                        size: 32,
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
                  //Campo Nome do Animal
                  const Text(
                    'Nome do Animal',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTextField('digite o nome do seu animal aqui...'),
                  const SizedBox(height: 20),

                  // Campo especie do animal
                  const Text(
                    'Espécie do Animal',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: _buildDropdownSimulado('Cachorro')),
                      const SizedBox(width: 16), // Espaço no meio
                      Expanded(child: _buildDropdownSimulado('Gato')),
                    ],
                  ),
                  const SizedBox(height: 20),

                  //Campo Anivrsario
                  const Text(
                    'Aniversário do Animal',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTextField('DD/MM/AAAA'),
                  const SizedBox(height: 20),

                  //Campo Descrição
                  const Text(
                    'Adicionar descrição',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTextField('Descrição do seu animal...', maxLines: 3),
                  const SizedBox(height: 40),

                  //Botão Contiuar
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReviewPetScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Continuar',
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

  // Constrói as caixas de texto padrões
  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF5A809E)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2D6A9F)),
        ),
      ),
    );
  }

  // Constrói os botões falsos de seleção (Cachorro/Gato)
  Widget _buildDropdownSimulado(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(color: Color(0xFF2D6A9F), fontSize: 15),
          ),
          const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
        ],
      ),
    );
  }
}
