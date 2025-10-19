import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Column(
            children: [
              // Header avatar + name + role
              _ProfileHeader(
                name: 'Abel Solo',
                role: 'Auditeur Segnor',
                company: 'FACYL-AUDIT',
                onChangePhoto: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Changer la photo — à venir')),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Infos card
              _SectionCard(
                title: 'Informations',
                child: Column(
                  children: const [
                    _InfoRow(
                      icon: Icons.badge_rounded,
                      label: 'Poste',
                      value: 'Auditeur Interne',
                    ),
                    _InfoRow(
                      icon: Icons.apartment_rounded,
                      label: 'Département',
                      value: 'Audit & Conseil',
                    ),
                    _InfoRow(
                      icon: Icons.mail_rounded,
                      label: 'Email',
                      value: 'mohamed.reda@facyl-audit.com',
                    ),
                    _InfoRow(
                      icon: Icons.phone_rounded,
                      label: 'Téléphone',
                      value: '+237 690 17 37 41',
                    ),
                    _InfoRow(
                      icon: Icons.place_rounded,
                      label: 'Localisation',
                      value: 'Bastos, Yaoundé — Cameroun',
                    ),
                    _InfoRow(
                      icon: Icons.tag_rounded,
                      label: 'Matricule',
                      value: 'FA-AUD-042',
                    ),
                    _InfoRow(
                      icon: Icons.manage_accounts_rounded,
                      label: 'Manager',
                      value: 'Mme. A. Yao',
                    ),
                    _InfoRow(
                      icon: Icons.event_available_rounded,
                      label: 'Date d’arrivée',
                      value: '06 Mar 2023',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Quick actions
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Modifier le profil — à venir')),
                        );
                      },
                      icon: const Icon(Icons.edit_rounded),
                      label: const Text('Modifier'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Paramètres — à venir')),
                        );
                      },
                      icon: const Icon(Icons.settings_rounded),
                      label: const Text('Paramètres'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Disconnect
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: cs.error,
                    foregroundColor: cs.onError,
                  ),
                  onPressed: () async {
                    final ok = await _confirmSignOut(context);
                    if (ok && context.mounted) {
                      // TODO: hook into your auth/logout flow here
                      Navigator.of(context).pop(); // simple example: back to Home
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Déconnecté')),
                      );
                    }
                  },
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Se déconnecter'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _confirmSignOut(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (ctx) {
            final cs = Theme.of(ctx).colorScheme;
            return AlertDialog(
              title: const Text('Confirmer la déconnexion'),
              content: const Text(
                'Voulez-vous vraiment vous déconnecter ?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text('Annuler'),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: cs.error,
                    foregroundColor: cs.onError,
                  ),
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text('Se déconnecter'),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}

class _ProfileHeader extends StatelessWidget {
  final String name;
  final String role;
  final String company;
  final VoidCallback onChangePhoto;

  const _ProfileHeader({
    required this.name,
    required this.role,
    required this.company,
    required this.onChangePhoto,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            const CircleAvatar(
              radius: 48,
              backgroundImage: AssetImage('assets/toto.png'),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onChangePhoto,
                borderRadius: BorderRadius.circular(18),
                child: Ink(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(Icons.photo_camera_rounded,
                      size: 18, color: cs.onPrimaryContainer),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 4),
        Text(
          '$role • $company',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: cs.onSurfaceVariant),
        ),
      ],
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
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: cs.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.35)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: cs.onPrimaryContainer),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: cs.onSurfaceVariant,
                        )),
                const SizedBox(height: 2),
                Text(value,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
