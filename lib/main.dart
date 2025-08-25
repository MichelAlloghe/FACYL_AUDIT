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
                    'assets/logo_FACYL.jpg', // place your HD logo here
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),
            Text(
              'Votre portail mobile',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
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
                      // nicer icon style (rounded)
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
                      title: 'Profil',
                      bigIcon: Icons.account_circle_rounded,
                      routeBuilder: ProfileScreen.new,
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

/// Menu tile styled to match the provided layout (icon in top-left, title bold bottom-left)
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
                  // beautiful, rounded icon in brand color (top-left)
                  Align(
                    alignment: Alignment.topLeft,
                    child: Icon(
                      bigIcon,
                      size: 48,
                      color: const Color(0xFFE53935),
                    ),
                  ),
                  // big bold label (bottom-left)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall
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

// --- Placeholder screens for navigation ---

class CompanyDetailScreen extends StatelessWidget {
  const CompanyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('À propos')),
      body: Center(
        child: Hero(
          tag: 'facyl_logo',
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset('assets/logo.png', height: 120),
          ),
        ),
      ),
    );
  }
}

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

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Center(
        child: Icon(Icons.account_circle_rounded, size: 96, color: cs.primary),
      ),
    );
  }
}
