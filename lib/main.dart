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
              backgroundImage: AssetImage("assets/profile.jpg"), // Mets ton image ici
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

            // The 2x2 GRID exactly like your screenshot
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
                      routeBuilder: () => EventsScreen(),
                    ),
                    MenuTile(
                      title: 'Quiz',
                      bigIcon: Icons.quiz_rounded,
                      routeBuilder: () => QuizScreen(),
                    ),
                    MenuTile(
                      title: 'Rapports',
                      bigIcon: Icons.bar_chart_rounded,
                      routeBuilder: () => ReportsScreen(),
                    ),
                    MenuTile(
                      title: 'Documentation',
                      bigIcon: Icons.menu_book_rounded,
                      routeBuilder: () => DocumentationScreen(),
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
                'Grille 1: Événements • 2: Quiz • 3: Rapports • 4: Profil',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
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

// --- Écran À propos ---
class CompanyDetailScreen extends StatelessWidget {
  const CompanyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('À propos')),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/logo_FACYL.jpg', height: 100),
              const SizedBox(height: 16),
              const Text(
                "Facyl-Audit\nApplication mobile",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Écran Profil ---
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Mon profil")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 0,
          color: cs.surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Commencer',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  'Répondez à quelques questions pour tester vos connaissances.',
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Démarrer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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

// --- Nouveaux écrans Documentation ---

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
          tileColor: cs.surfaceContainerHighest,
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFE53935),
            child: const Icon(Icons.event),
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

// --- Quiz ---
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 0,
          color: cs.surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Commencer',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Répondez à quelques questions pour tester vos connaissances.',
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Démarrer'),
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

// --- Documentation ---
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
          color: cs.surfaceContainerHighest,
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
          color: cs.surfaceContainerHighest,
          child: ListTile(
            leading: const Icon(Icons.article_outlined),
            title: Text(normes[i]),
          ),
        ),
      ),
    );
  }
}

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
          color: cs.surfaceContainerHighest,
          child: ListTile(
            leading: const Icon(Icons.article_outlined),
            title: Text(normes[i]),
          ),
        ),
      ),
    );
  }
}

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
          color: cs.surfaceContainerHighest,
          child: ListTile(
            leading: const Icon(Icons.article_outlined),
            title: Text(normes[i]),
          ),
        ),
      ),
    );
  }

  
}

class CompanyDetailScreen extends StatelessWidget {
  const CompanyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('À propos')),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/logo_FACYL.jpg', height: 100),
              const SizedBox(height: 16),
              const Text(
                "Facyl-Audit\nApplication mobile",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}