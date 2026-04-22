import 'package:flutter/material.dart';

void main() {
  runApp(const StudentCampaignApp());
}

class StudentCampaignApp extends StatelessWidget {
  const StudentCampaignApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campaña Presidencial Estudiantil',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A), // Deep Blue
          secondary: const Color(0xFFF59E0B), // Amber
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const BrochureScreen(),
    );
  }
}

class BrochureScreen extends StatefulWidget {
  const BrochureScreen({super.key});

  @override
  State<BrochureScreen> createState() => _BrochureScreenState();
}

class _BrochureScreenState extends State<BrochureScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _panels = [
    const PanelCover(),
    const PanelAboutMe(),
    const PanelProposals(),
    const PanelValues(),
    const PanelVotingInfo(),
    const PanelBackCover(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _panels.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: _panels,
          ),
          
          // Navigation Indicators and Buttons
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currentPage > 0
                    ? FloatingActionButton.small(
                        heroTag: 'prev',
                        onPressed: _previousPage,
                        backgroundColor: Colors.white.withOpacity(0.8),
                        child: const Icon(Icons.arrow_back_ios_new, size: 16),
                      )
                    : const SizedBox(width: 40),
                
                // Page Dots
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    _panels.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                
                _currentPage < _panels.length - 1
                    ? FloatingActionButton.small(
                        heroTag: 'next',
                        onPressed: _nextPage,
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        child: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                      )
                    : const SizedBox(width: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// PANEL 1: Portada (Cover)
// ---------------------------------------------------------
class PanelCover extends StatelessWidget {
  const PanelCover({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 80,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 100, color: Colors.grey),
          ),
          const SizedBox(height: 32),
          const Text(
            '¡VOTA POR\nALEJANDRO!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'PARA PRESIDENTE ESTUDIANTIL',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            '"Construyendo juntos la escuela que queremos"',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// PANEL 2: ¿Quién soy? (About Me)
// ---------------------------------------------------------
class PanelAboutMe extends StatelessWidget {
  const PanelAboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.waving_hand_rounded,
            size: 48,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 24),
          Text(
            '¿Quién soy?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Hola, soy Alejandro, estudiante de 4to año. Desde que llegué a esta escuela, he estado involucrado en organizar eventos deportivos y clubes de debate.',
            style: TextStyle(fontSize: 18, height: 1.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'Conozco los problemas que enfrentamos a diario, desde los horarios de la cafetería hasta la falta de espacios recreativos. Quiero ser tu voz ante la dirección escolar.',
            style: TextStyle(fontSize: 18, height: 1.5),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// PANEL 3: Propuestas (Proposals)
// ---------------------------------------------------------
class PanelProposals extends StatelessWidget {
  const PanelProposals({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF3F4F6),
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Mis Propuestas',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 32),
          _buildProposal(
            context,
            icon: Icons.restaurant,
            title: 'Mejoras en la Cafetería',
            description: 'Más opciones saludables y ampliación de los horarios de atención durante los recesos.',
          ),
          const SizedBox(height: 20),
          _buildProposal(
            context,
            icon: Icons.sports_basketball,
            title: 'Torneos Deportivos Mixtos',
            description: 'Organización de ligas internas de fútbol, voleibol y baloncesto cada semestre.',
          ),
          const SizedBox(height: 20),
          _buildProposal(
            context,
            icon: Icons.wifi,
            title: 'Internet Estudiantil',
            description: 'Gestionar la apertura de redes Wi-Fi exclusivas para uso académico en la biblioteca.',
          ),
        ],
      ),
    );
  }

  Widget _buildProposal(BuildContext context, {required IconData icon, required String title, required String description}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------
// PANEL 4: Valores (Values)
// ---------------------------------------------------------
class PanelValues extends StatelessWidget {
  const PanelValues({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '¿Por qué votar por mí?',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 32),
          _buildValueItem(context, 'Transparencia', 'Cada decisión del consejo se compartirá en el boletín escolar.'),
          const Divider(height: 32),
          _buildValueItem(context, 'Inclusión', 'Todas las voces importan. Crearemos un buzón de sugerencias anónimo.'),
          const Divider(height: 32),
          _buildValueItem(context, 'Acción', 'Menos promesas vacías, más resultados visibles desde el primer mes.'),
        ],
      ),
    );
  }

  Widget _buildValueItem(BuildContext context, String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------
// PANEL 5: Cómo Votar (Voting Info)
// ---------------------------------------------------------
class PanelVotingInfo extends StatelessWidget {
  const PanelVotingInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.how_to_vote, size: 80, color: Colors.white),
          const SizedBox(height: 24),
          const Text(
            '¡TU VOTO HACE LA DIFERENCIA!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          _buildInfoBox(Icons.calendar_today, 'Día de Elecciones', 'Viernes, 15 de Noviembre'),
          const SizedBox(height: 16),
          _buildInfoBox(Icons.location_on, 'Lugar', 'Auditorio Principal'),
          const SizedBox(height: 16),
          _buildInfoBox(Icons.badge, 'Requisito', 'Llevar tu credencial de estudiante'),
        ],
      ),
    );
  }

  Widget _buildInfoBox(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// PANEL 6: Contraportada (Back Cover)
// ---------------------------------------------------------
class PanelBackCover extends StatelessWidget {
  const PanelBackCover({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'VOTA PLANILLA AZUL',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            'Contáctame:',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 20),
          _buildContactRow(Icons.email, 'alejandro@escuela.edu'),
          const SizedBox(height: 16),
          _buildContactRow(Icons.camera_alt, '@ale_presidente2026'),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Icon(Icons.check_box, color: Theme.of(context).colorScheme.secondary, size: 48),
                const SizedBox(height: 16),
                const Text(
                  'Este 15 de Noviembre, marca la diferencia.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
