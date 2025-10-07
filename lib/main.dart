// lib/main.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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
              backgroundImage: AssetImage("assets/toto.png"), // nouvelle image
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),

      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
            const SizedBox(height: 8),
            Text(
              'Votre portail mobile',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
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
                  children: [
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
                  ],
                ),
              ),
            ),

            // FOOTER LEGEND
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
              child: Text(
                '1: Événements • 2: Quiz • 3: Rapports • 4: Documentation',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                textAlign: TextAlign.center,
=======
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

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
>>>>>>> 5b5ead2eff0b5b2c0a957416b583bacd79fe74f1
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/toto.png"), // nouvelle image
            ),
            const SizedBox(height: 20),

            // Nom & Prénom
            const Text(
              "Nom : MH",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Text(
              "Prénom : Bertrand",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Text(
              "Poste : Auditeur financier",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),

            const SizedBox(height: 30),

            // Adresse postale
            Row(
              children: const [
                Icon(Icons.home, color: Colors.grey),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "15 rue Jules Grandjouan\n4400 Nantes",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Adresse mail
            Row(
              children: const [
                Icon(Icons.email, color: Colors.grey),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "mh.bertrand.@facyl-audit.com",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Numéro de téléphone
            Row(
              children: const [
                Icon(Icons.phone, color: Colors.grey),
                SizedBox(width: 10),
                Expanded(
                  child: Text("07 06 05 04 33", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),

            const Spacer(),

            FilledButton.icon(
              onPressed: () {
                Navigator.pop(context); // Simule une déconnexion
              },
              icon: const Icon(Icons.logout),
              label: const Text("Déconnexion"),
              style: FilledButton.styleFrom(backgroundColor: cs.error),
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
                  'Commencer',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Icône principale
            Center(
              child: Icon(
                Icons.insert_chart_outlined_rounded,
                size: 96,
                color: cs.primary,
              ),
            ),
            const SizedBox(height: 40),

            // Bouton : Éditer mon rapport d'activité
            FilledButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Info"),
                    content: const Text("Fonctionnalité à venir"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.edit_document),
              label: const Text("Éditer mon rapport d'activité"),
            ),

            const SizedBox(height: 16),

            // Bouton : Générer mon rapport d'audit
            FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const UploadReportScreen()),
                );
              },
              icon: const Icon(Icons.description),
              label: const Text("Générer mon rapport d'audit"),
            ),
          ],
        ),
      ),
    );
  }
}

// -- Uploader Screen --
class UploadReportScreen extends StatefulWidget {
  const UploadReportScreen({super.key});

  @override
  State<UploadReportScreen> createState() => _UploadReportScreenState();
}

class _UploadReportScreenState extends State<UploadReportScreen> {
  bool _loading = false;

  void _simulateUpload() {
    setState(() => _loading = true);

    // Simule un traitement de 3 secondes
    Future.delayed(const Duration(seconds: 3), () {
      setState(() => _loading = false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuditReportScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Téléversement fichier")),
      body: Center(
        child: _loading
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  Text(
                    "Traitement du fichier en cours...",
                    style: TextStyle(color: cs.primary),
                  ),
                ],
              )
            : FilledButton.icon(
                onPressed: _simulateUpload,
                icon: const Icon(Icons.upload_file),
                label: const Text("Téléverser le fichier à traiter"),
              ),
      ),
    );
  }
}

// -- Génération Rapport --
class AuditReportScreen extends StatelessWidget {
  const AuditReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rapport d'audit"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Succès"),
                  content: const Text("Rapport téléchargé"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.download_rounded),
            tooltip: "Télécharger le rapport",
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // En-tête stylisé
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: cs.primary.withOpacity(0.1),
                  radius: 28,
                  child: Icon(Icons.assignment_turned_in_rounded,
                      size: 32, color: cs.primary),
                ),
                const SizedBox(width: 16),
                Text(
                  "Rapport d’audit 2025",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: cs.primary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Carte Résumé
            _ReportCard(
              title: "Résumé",
              content:
                  "Ce rapport présente une évaluation synthétique de l’audit réalisé. "
                  "Globalement, les objectifs de conformité ont été partiellement atteints, "
                  "avec des recommandations pour renforcer certains processus.",
              icon: Icons.summarize_rounded,
            ),

            const SizedBox(height: 20),

            // Carte Objectifs
            _ReportCard(
              title: "Objectifs",
              content:
                  "1. Vérifier la conformité réglementaire\n"
                  "2. Identifier les risques financiers\n"
                  "3. Proposer des recommandations stratégiques",
              icon: Icons.track_changes_rounded,
            ),

            const SizedBox(height: 20),

            // Carte Méthodologie
            _ReportCard(
              title: "Méthodologie",
              content:
                  "L'audit a été conduit selon les normes ISA et NEP. "
                  "Les méthodes utilisées incluent :\n- Entretiens\n- Analyse documentaire\n- Tests de procédures",
              icon: Icons.biotech_rounded,
            ),

            const SizedBox(height: 20),

            // Carte Conclusions avec graphique
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 3,
              color: cs.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle_rounded,
                            color: cs.primary, size: 28),
                        const SizedBox(width: 10),
                        Text(
                          "Conclusions",
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: cs.primary,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "• Points positifs : bonne gestion des risques financiers\n"
                      "• Non-conformités : documentation interne incomplète\n"
                      "• Recommandations : renforcer le contrôle interne et digitaliser les rapports",
                    ),
                    const SizedBox(height: 20),

                    // Ajout du graphique en camembert
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: 65,
                              title: "65%\nConformité",
                              color: Colors.green,
                              radius: 70,
                              titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            PieChartSectionData(
                              value: 25,
                              title: "25%\nPartiel",
                              color: Colors.orange,
                              radius: 60,
                              titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            PieChartSectionData(
                              value: 10,
                              title: "10%\nNon-conforme",
                              color: Colors.red,
                              radius: 50,
                              titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ],
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget réutilisable pour les sections
class _ReportCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;

  const _ReportCard({
    required this.title,
    required this.content,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 3,
      color: cs.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: cs.primary, size: 28),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: cs.primary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(content, style: Theme.of(context).textTheme.bodyMedium),
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
