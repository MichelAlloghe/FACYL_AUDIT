import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // AppBar avec hero du logo + gradient
          SliverAppBar(
            pinned: true,
            expandedHeight: 180,
            backgroundColor: cs.primary,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsetsDirectional.only(start: 16, bottom: 12),
              title: Text(
                'À propos',
                style: TextStyle(color: cs.onPrimary, fontWeight: FontWeight.w700),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [cs.primary, cs.secondary.withOpacity(0.9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Hero(
                    tag: 'facyl_logo',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/logo_FACYL.jpg',
                        height: 90,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Présentation rapide
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
              child: _SectionCard(
                title: "Facyl-Audit — Cabinet d’audit et de conseil",
                child: Text(
                  "Bienvenue chez Facyl_Audit ! Nous sommes une équipe passionnée et expérimentée dédiée à fournir des solutions d’audit et de conseil de haute qualité pour répondre aux besoins uniques de nos clients.\n\n"
                  "Avec nous, vous avez droit à des services personnalisés et innovants dans les domaines d’audit financier et SI, de management des risques, de fiscalité, de gestion, de due diligence et de comptabilité. "
                  "Nous accompagnons les personnes désirant poursuivre leurs études en comptabilité, audit et finance à l’étranger.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),

          // Contact cards
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: const [
                  _InfoChip(
                    icon: Icons.call_rounded,
                    label: "Phone",
                    value: "+237 690 17 37 41\n+336 86 78 25 48",
                  ),
                  _InfoChip(
                    icon: Icons.mail_rounded,
                    label: "Courriel",
                    value: "facyl_audit@yahoo.com",
                  ),
                  _InfoChip(
                    icon: Icons.place_rounded,
                    label: "Address",
                    value: "Bastos, Yaoundé, Cameroun;\nOrléans, France.",
                  ),
                ],
              ),
            ),
          ),

          // Services (grid) — uniform tiles, short bottom descriptions
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            sliver: SliverToBoxAdapter(
              child: _SectionCard(
                title: "Nos services",
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.05, // same slot for every tile
                  ),
                  children: const [
                    _ServiceTile(
                      icon: Icons.fact_check_rounded,
                      title: "Audit",
                      description: "Fiabilité & conformité.",
                    ),
                    _ServiceTile(
                      icon: Icons.handshake_rounded,
                      title: "Conseil",
                      description: "Appui stratégique.",
                    ),
                    _ServiceTile(
                      icon: Icons.calculate_rounded,
                      title: "Comptabilité",
                      description: "Tenue & états.",
                    ),
                    _ServiceTile(
                      icon: Icons.balance_rounded,
                      title: "Fiscalité",
                      description: "Optimisation fiscale.",
                    ),
                    _ServiceTile(
                      icon: Icons.shield_rounded,
                      title: "Management des risques",
                      description: "Identification & prévention.",
                    ),
                    _ServiceTile(
                      icon: Icons.search_rounded,
                      title: "Évaluation & Due Diligence",
                      description: "Analyses d’entreprise.",
                    ),
                    _ServiceTile(
                      icon: Icons.school_rounded,
                      title: "Formation",
                      description: "Ateliers pratiques.",
                    ),
                    _ServiceTile(
                      icon: Icons.route_rounded,
                      title: "Accompagnement",
                      description: "Plans de croissance.",
                    ),
                  ],
                ),
              ),
            ),
          ),

          // --- Notre engagement (version originale restaurée) ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: _SectionCard(
                title: "Notre engagement",
                child: Text(
                  "Notre engagement envers l’excellence, l’intégrité et la collaboration garantit que nous travaillons en partenariat avec vous pour atteindre vos objectifs et optimiser votre succès financier.\n\n"
                  "Faites équipe avec nous pour une vision claire, des solutions efficaces et une croissance durable.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),

          // Slogan
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Center(
                child: Text(
                  "We work for your success!",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: cs.primary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: 360,
      constraints: const BoxConstraints(minWidth: 260),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.35)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: cs.onPrimaryContainer),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: "$label\n",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.35)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  const _ServiceTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Equal-size tiles handled by grid; we pin short description at bottom.
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon chip
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: cs.onPrimaryContainer),
          ),
          const SizedBox(height: 12),

          // Title (up to 2 lines)
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),

          // Push description to the bottom
          const Spacer(),

          // Short one-liner description
          Text(
            description,
            maxLines: 1, // keep it one line to avoid any overflow
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
