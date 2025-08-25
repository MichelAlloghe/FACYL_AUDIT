// lib/main.dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFFE53935); // Facyl red
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Facyl-Audit',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Facyl-Audit"),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
            icon: const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage("assets/profile.jpg"), // ← Mets ton image ici
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER with clickable logo
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CompanyDetailScreen(),
                  ),
                ),
                child: Hero(
                  tag: 'facyl_logo',
                  child: Image.asset(
                    'assets/logo_FACYL.jpg',
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),
            Text(
              'Votre portail mobile',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // The GRID (Profil retiré)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: 1.02,
                  children: const [
                    MenuTile(
                      title: 'Événements',
                      bigIcon: Icons.calendar_month_rounded,
                      routeBuilder: EventsScreen.new,
                    ),
                    MenuTile(
                      title: 'Quiz',
                      bigIcon: Icons.quiz_rounded,
                      routeBuilder: QuizScreen.new,
                    ),
                    MenuTile(
                      title: 'Rapports',
                      bigIcon: Icons.bar_chart_rounded,
                      routeBuilder: ReportsScreen.new,
                    ),
                    MenuTile(
                      title: 'Documentation',
                      bigIcon: Icons.menu_book_rounded,
                      routeBuilder: DocumentationScreen.new,
                    ),
                  ],
                ),
              ),
            ),

            // FOOTER LEGEND
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
              child: Text(
                '1: Événements • 2: Quiz • 3: Rapports • 4: Documentation',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: cs.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Menu tile
class MenuTile extends StatelessWidget {
  final String title;
  final IconData bigIcon;
  final Widget Function() routeBuilder;

  const MenuTile({
    super.key,
    required this.title,
    required this.bigIcon,
    required this.routeBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Hero(
      tag: 'tile_$title',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => routeBuilder()),
          ),
          child: Ink(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
              border: Border.all(color: cs.outlineVariant.withOpacity(0.35)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Icon(
                      bigIcon,
                      size: 48,
                      color: const Color(0xFFE53935),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- Écrans existants : EventsScreen, QuizScreen, ReportsScreen, DocumentationScreen... (inchangés) ---

/// Nouvel écran Profil
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Mon profil")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/profile.jpg"), // ← Mets ton image
            ),
            const SizedBox(height: 20),
            const Text("Nom : Dupont",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const Text("Prénom : Jean",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const Text("Poste : Auditeur financier",
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
            const Spacer(),
            FilledButton.icon(
              onPressed: () {
                Navigator.pop(context); // Simule la déconnexion
              },
              icon: const Icon(Icons.logout),
              label: const Text("Déconnexion"),
              style: FilledButton.styleFrom(
                backgroundColor: cs.error,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
