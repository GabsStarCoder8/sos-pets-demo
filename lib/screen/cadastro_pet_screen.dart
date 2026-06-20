import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/pet_model.dart';
import 'review_pet_screen.dart';

class CadastroPetScreen extends StatefulWidget {
  const CadastroPetScreen({super.key});

  @override
  State<CadastroPetScreen> createState() => _CadastroPetScreenState();
}

class _CadastroPetScreenState extends State<CadastroPetScreen> {
  static const Color primaryColor = Color(0xFF2D6A9F);
  static const Color lightBlue = Color(0xFFABCBE5);

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  String _especieSelecionada = 'Cachorro';

  @override
  void dispose() {
    _nomeController.dispose();
    _dataController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _irParaRevisao() {
    if (_nomeController.text.trim().isEmpty ||
        _dataController.text.trim().isEmpty ||
        _descricaoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    PetModel petProvisorio = PetModel(
      idPet: '',
      idDono: '',
      nomeAnimal: _nomeController.text.trim(),
      especie: _especieSelecionada,
      dataNascimento: _dataController.text.trim(),
      descricao: _descricaoController.text.trim(),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewPetScreen(pet: petProvisorio),
      ),
    );
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
                  const Text(
                    'Nome do Animal',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    _nomeController,
                    'digite o nome do seu animal aqui...',
                  ),
                  const SizedBox(height: 20),

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
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _especieSelecionada = 'Cachorro'),
                          child: _buildSelecaoEspecie(
                            'Cachorro',
                            _especieSelecionada == 'Cachorro',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _especieSelecionada = 'Gato'),
                          child: _buildSelecaoEspecie(
                            'Gato',
                            _especieSelecionada == 'Gato',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Aniversário do Animal',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(_dataController, 'DD/MM/AAAA'),
                  const SizedBox(height: 20),

                  const Text(
                    'Adicionar descrição',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(
                    _descricaoController,
                    'Descrição do seu animal...',
                    maxLines: 3,
                  ),
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
                      onPressed: _irParaRevisao,
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

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
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

  Widget _buildSelecaoEspecie(String texto, bool selecionado) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: selecionado
            ? const Color(0xFF2D6A9F).withOpacity(0.1)
            : Colors.white, // Fundo destacado se selecionado
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selecionado ? const Color(0xFF2D6A9F) : Colors.black12,
          width: selecionado ? 2 : 1,
        ),
      ),
      child: Center(
        child: Text(
          texto,
          style: TextStyle(
            color: const Color(0xFF2D6A9F),
            fontSize: 15,
            fontWeight: selecionado ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
