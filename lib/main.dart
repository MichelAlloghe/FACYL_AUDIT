// lib/main.dart
import 'package:flutter/material.dart';
import 'theme.dart';
import 'quiz_screen.dart';
import 'about_us_screen.dart';
import 'profile_screen.dart' as profile;
import 'SplashScreen.dart';



void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const seed = Color(0xFFE53935); // Facyl red

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Facyl-Audit',
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: '/', // <-- start on Splash
      routes: {
        '/': (_) => const SplashScreen(), // first page
        '/home': (_) => const HomeScreen(),
        '/profile': (_) => const profile.ProfileScreen()
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // LOGO at the top (modern style)
            // LOGO at the top (clickable → AboutUs)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
                child: Hero(
                  tag: 'facyl_logo',
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AboutUsScreen(),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/logo_FACYL.jpg',
                            height: 90,
                            width: double.infinity, // keeps the hero stable
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // PROFILE HEADER
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: const _ProfileHeader(),
              ),
            ),

            // MENU GRID
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.05,
                ),
                delegate: SliverChildListDelegate.fixed([
                  MenuTileNew(
                    title: 'Événements',
                    icon: Icons.calendar_month_rounded,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EventsScreen()),
                    ),
                  ),
                  MenuTileNew(
                    title: 'Quiz',
                    icon: Icons.quiz_rounded,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const QuizIntroScreen(),
                      ),
                    ),
                  ),
                  MenuTileNew(
                    title: 'Rapports',
                    icon: Icons.bar_chart_rounded,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ReportsScreen()),
                    ),
                  ),
                  MenuTileNew(
                    title: 'Documentation',
                    icon: Icons.menu_book_rounded,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DocumentationScreen(),
                      ),
                    ),
                  ),
                ]),
              ),
            ),

            // LEGEND FOOTER
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
                child: Text(
                  'Événements • Quiz • Rapports • Documentation',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Modern profile header with gradient background
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primary, cs.tertiary.withOpacity(0.95)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 10, 14),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage("assets/profile.jpg"),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mohamed Reda',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: cs.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Opacity(
                  opacity: 0.9,
                  child: Text(
                    '@auditor',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: cs.onPrimary),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/profile'),
            icon: Icon(Icons.chevron_right, color: cs.onPrimary),
          ),
        ],
      ),
    );
  }
}

/// New compact tile that ensures text fits (centered, 2 lines max)
class MenuTileNew extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const MenuTileNew({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? cs.surface
                : cs.surfaceVariant.withOpacity(0.6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: cs.outlineVariant.withOpacity(0.35)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 16,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, size: 32, color: cs.onPrimaryContainer),
                ),
                const Spacer(),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Rapports ---
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Rapports')),
      body: Center(
        child: Icon(
          Icons.insert_chart_outlined_rounded,
          size: 96,
          color: cs.primary,
        ),
      ),
    );
  }
}

// --- Événements ---
class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Événements')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) => ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          tileColor: cs.surfaceVariant,
          leading: const CircleAvatar(
            backgroundColor: Color(0xFFE53935),
            child: Icon(Icons.event),
          ),
          title: Text('Événement ${i + 1}'),
          subtitle: const Text('Date • Lieu • Description'),
          trailing: Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
          onTap: () {},
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Nouveau'),
      ),
    );
  }
}

// --- Documentation (menu) ---
class DocumentationScreen extends StatelessWidget {
  const DocumentationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Documentation')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NormesInternationaleScreen(),
                ),
              ),
              icon: const Icon(Icons.public),
              label: const Text('Normes internationales d’audit'),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NormesFrancaiseScreen(),
                ),
              ),
              icon: const Icon(Icons.flag),
              label: const Text('Normes françaises d’audit'),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Normes Internationales ---
class NormesInternationaleScreen extends StatelessWidget {
  const NormesInternationaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final normes = [
      "ISA 200 : Objectifs globaux de l’auditeur indépendant",
      "ISA 315 : Identification et évaluation des risques",
      "ISA 500 : Éléments probants",
      "ISA 700 : Rapport de l’auditeur sur les états financiers",
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Normes internationales')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: normes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) => Card(
          color: cs.surfaceVariant,
          child: ListTile(
            leading: const Icon(Icons.article_outlined),
            title: Text(normes[i]),
          ),
        ),
      ),
    );
  }
}

// --- Normes Françaises ---
class NormesFrancaiseScreen extends StatelessWidget {
  const NormesFrancaiseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final normes = [
      "NEP 200 : Objectifs et principes généraux",
      "NEP 240 : Responsabilités de l’auditeur concernant la fraude",
      "NEP 300 : Planification de l’audit",
      "NEP 700 : Rapport de certification",
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Normes françaises')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: normes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) => Card(
          color: cs.surfaceVariant,
          child: ListTile(
            leading: const Icon(Icons.article_outlined),
            title: Text(normes[i]),
          ),
        ),
      ),
    );
  }
}
