// lib/main.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'theme.dart';
import 'quiz_screen.dart';
import 'about_us_screen.dart';
import 'profile_screen.dart' as profile;
import 'SplashScreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const seed = Color(0xFFE53935); // Rouge Facyl

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Facyl-Audit',
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/home': (_) => const HomeScreen(),
        '/profile': (_) => const profile.ProfileScreen(),
      },
    );
  }
}

// ----------------------------------------------------
// ------------------- HOME SCREEN --------------------
// ----------------------------------------------------
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
            onPressed: () => Navigator.pushNamed(context, '/profile'),
            icon: const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage("assets/toto.png"),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // LOGO cliquable
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
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // HEADER
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Votre portail mobile',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // PROFIL HEADER
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
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
                      MaterialPageRoute(builder: (_) => const EventScreen()),
                    ),
                  ),
                  MenuTileNew(
                    title: 'Quiz',
                    icon: Icons.quiz_rounded,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const QuizIntroScreen()),
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

            // FOOTER
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
                child: Text(
                  'Événements • Quiz • Rapports • Documentation',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: cs.onSurfaceVariant),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// ---------------- PROFILE HEADER --------------------
// ----------------------------------------------------
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
            backgroundImage: AssetImage("assets/toto.png"),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Abel Solo',
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
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: cs.onPrimary),
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

// ----------------------------------------------------
// ------------------ MENU TILE NEW -------------------
// ----------------------------------------------------
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
          onTap: onTap,
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
                      icon,
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
                          .titleMedium
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

// ----------------------------------------------------
// ---------------- OTHER SCREENS ---------------------
// ----------------------------------------------------
class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final events = [
      {
        "title": "Ouverture FACYL-AUDIT France",
        "date": "07 fevrier 2026",
        "location": "Orleans, France",
        "description": "Ouverture du premier cabinet FACYL-AUDIT en France.",
        "url": "https://www.facyl-audit.fr"
      },
      {
        "title": "Conférence Audit et Gouvernance 2026",
        "date": "12-13 mai 2026",
        "location": "Paris, France",
        "description": "Événement majeur réunissant les auditeurs et responsables de gouvernance pour discuter des dernières pratiques et normes en France.",
        "url": "https://www.audit-gouvernance.fr/conference-2026"
      },
      {
        "title": "Forum National de l'Audit Interne",
        "date": "17 juin 2026",
        "location": "Lyon, France",
        "description": "Forum annuel dédié aux auditeurs internes français, mettant l'accent sur la conformité, la cybersécurité et la gestion des risques.",
        "url": "https://www.forumaudit.fr/2026"
      },
      {
        "title": "Journée Nationale de l'Audit",
        "date": "23 septembre 2026",
        "location": "Marseille, France",
        "description": "Rencontre nationale pour échanger sur les tendances en audit et les innovations dans le domaine.",
        "url": "https://www.auditfrance.org/jna-2026"
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Événements d\'audit 2026 (France)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: events.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) => Card(
            color: cs.surfaceVariant,
            child: ListTile(
              leading: const Icon(Icons.event_outlined),
              title: Text(events[i]["title"]!),
              subtitle: Text('${events[i]["date"]!} – ${events[i]["location"]!}'),
              trailing: IconButton(
                icon: const Icon(Icons.link),
                onPressed: () => launchUrl(Uri.parse(events[i]["url"]!)),
              ),
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
                  "Rapport d’audit 2026",
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
                  "Ce rapport présente l'évaluation de l’audit 2026 en France. "
                  "Les objectifs principaux ont été atteints, avec des recommandations pour renforcer la conformité et la sécurité financière.",
              icon: Icons.summarize_rounded,
            ),
            const SizedBox(height: 20),

            // Carte Objectifs
            _ReportCard(
              title: "Objectifs",
              content: "1. Vérifier la conformité aux normes nationales et internationales\n"
                  "2. Identifier les risques financiers et opérationnels\n"
                  "3. Proposer des recommandations stratégiques et opérationnelles",
              icon: Icons.track_changes_rounded,
            ),
            const SizedBox(height: 20),

            // Carte Méthodologie
            _ReportCard(
              title: "Méthodologie",
              content: "L'audit 2026 a été conduit selon les normes ISA et NEP. "
                  "Les méthodes utilisées incluent :\n- Entretiens avec les équipes\n- Analyse documentaire\n- Tests de procédures",
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
                        Icon(Icons.check_circle_rounded, color: cs.primary, size: 28),
                        const SizedBox(width: 10),
                        Text(
                          "Conclusions",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: cs.primary,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "• Points positifs : bonne gestion des risques et conformité\n"
                      "• Non-conformités : documentation interne à compléter\n"
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
                              value: 70,
                              title: "70%\nConforme",
                              color: Colors.green,
                              radius: 70,
                              titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            PieChartSectionData(
                              value: 20,
                              title: "20%\nPartiel",
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

// class ReportsScreen extends StatelessWidget {
//   const ReportsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Rapports')),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: LineChart(
//             LineChartData(
//               gridData: FlGridData(show: true),
//               titlesData: FlTitlesData(show: true),
//               borderData: FlBorderData(show: true),
//               lineBarsData: [
//                 LineChartBarData(
//                   spots: [
//                     const FlSpot(0, 1),
//                     const FlSpot(1, 3),
//                     const FlSpot(2, 10),
//                     const FlSpot(3, 7),
//                     const FlSpot(4, 12),
//                   ],
//                   isCurved: true,
//                   dotData: FlDotData(show: true),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DocumentationScreen extends StatelessWidget {
//   const DocumentationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Documentation')),
//       body: const Center(
//         child: Text('Section documentation en cours de construction...'),
//       ),
//     );
//   }
// }

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
      "ISA 200 : Objectifs globaux de l'auditeur indépendant",
      "ISA 210 : Accords sur les termes de mission",
      "ISA 220 : Contrôle qualité pour un audit d'états financiers",
      "ISA 230 : Documentation de l'audit",
      "ISA 240 : Responsabilités de l'auditeur face aux fraudes",
      "ISA 250 : Prise en compte des lois et règlements",
      "ISA 315 : Identification et évaluation des risques",
      "ISA 320 : Importance relative dans la planification et l'exécution",
      "ISA 500 : Éléments probants",
      "ISA 700 : Rapport de l'auditeur sur les états financiers",
      "ISA 705 : Modifications à l'opinion dans le rapport de l'auditeur",
      "ISA 706 : Paragraphes d'observation et d'éléments clés",
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
      "NEP 100 : Objectifs et responsabilités de l'auditeur",
      "NEP 200 : Planification de la mission",
      "NEP 210 : Contrôle interne et évaluation des risques",
      "NEP 300 : Documentation de l'audit",
      "NEP 400 : Éléments probants et tests d'audit",
      "NEP 500 : Rapport de l'auditeur",
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
