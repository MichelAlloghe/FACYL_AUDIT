// lib/quiz_screen.dart
import 'dart:async';
import 'package:excel/excel.dart' as xls;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math' as math;
import 'package:confetti/confetti.dart';
/// --------- Modèle ----------
class QuizQuestion {
  final String question;
  final List<String> options; // 4 options A..D
  final int correctIndex; // 0..3

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

/// --------- Loader Excel ----------
class ExcelQuizLoader {
  /// Excel columns supported (case/spacing insensitive):
  /// Question | A | B | C | D | Correct
  /// "Correct" can be A/B/C/D or 1/2/3/4.
  static Future<List<QuizQuestion>> loadFromAsset(String assetPath) async {
    final bytes = await rootBundle.load(assetPath);
    final excel = xls.Excel.decodeBytes(bytes.buffer.asUint8List());

    // Find the first non-empty sheet (>= 2 rows: header + at least one data row)
    xls.Sheet? sheet;
    for (final t in excel.tables.values) {
      if (t.maxRows >= 2) {
        sheet = t;
        break;
      }
    }
    if (sheet == null) {
      // No usable sheet
      return [];
    }

    // Read header row safely
    final headerRow = sheet.row(0);
    if (headerRow.isEmpty) return [];

    String norm(String? s) => (s ?? '').trim().toLowerCase();

    final header = headerRow
        .map((c) => norm(c?.value?.toString()))
        .toList(growable: false);

    int colQ = header.indexOf('question');
    int colA = header.indexOf('a');
    int colB = header.indexOf('b');
    int colC = header.indexOf('c');
    int colD = header.indexOf('d');
    int colCorrect = header.indexOf('correct');

    // If any column missing, try a more tolerant match (e.g., french accents/spaces)
    List<String> keys = ['question', 'a', 'b', 'c', 'd', 'correct'];
    if ([colQ, colA, colB, colC, colD, colCorrect].contains(-1)) {
      // Try to map by contains (e.g., " question ", "réponse a", etc.)
      for (int i = 0; i < header.length; i++) {
        final h = header[i];
        if (colQ == -1 && h.contains('question')) colQ = i;
        if (colA == -1 && (h == 'a' || h.contains('rep a') || h.contains('a)')))
          colA = i;
        if (colB == -1 && (h == 'b' || h.contains('rep b') || h.contains('b)')))
          colB = i;
        if (colC == -1 && (h == 'c' || h.contains('rep c') || h.contains('c)')))
          colC = i;
        if (colD == -1 && (h == 'd' || h.contains('rep d') || h.contains('d)')))
          colD = i;
        if (colCorrect == -1 && (h.contains('correct') || h.contains('bonne')))
          colCorrect = i;
      }
    }

    // Still missing -> give up cleanly
    if ([colQ, colA, colB, colC, colD, colCorrect].contains(-1)) {
      return [];
    }

    final List<QuizQuestion> out = [];
    for (int r = 1; r < sheet.maxRows; r++) {
      final row = sheet.row(r);
      String cell(int col) =>
          (col >= 0 && col < row.length ? row[col]?.value : null)
              ?.toString()
              .trim() ??
          '';

      final q = cell(colQ);
      if (q.isEmpty) continue;

      final opts = [cell(colA), cell(colB), cell(colC), cell(colD)];

      final rawCorrect = cell(colCorrect).toUpperCase();
      int idx = switch (rawCorrect) {
        'A' => 0,
        'B' => 1,
        'C' => 2,
        'D' => 3,
        _ =>
          int.tryParse(rawCorrect) != null
              ? (int.parse(rawCorrect) - 1) // 1..4 -> 0..3
              : -1,
      };
      if (idx < 0 || idx > 3) continue;

      out.add(QuizQuestion(question: q, options: opts, correctIndex: idx));
    }
    return out;
  }
}

/// --------- Ecran d’intro ----------
class QuizIntroScreen extends StatelessWidget {
  const QuizIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // header violet/gradient style
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [cs.primary, cs.secondary.withOpacity(0.9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: cs.onPrimary.withOpacity(0.2),
                      child: Icon(
                        Icons.emoji_events_rounded,
                        color: cs.onPrimary,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        "Prêt(e) à vous challenger ?\nChoisissez une catégorie pour démarrer.",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: cs.onPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // cartes catégories (ex: une seule pour l’instant)
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.05,
                  children: [
                    _CategoryCard(
                      icon: Icons.fact_check_rounded,
                      title: 'Fondements de\nl’audit',
                      subtitle: '10 questions',
                      onTap: () async {
                        final questions = await ExcelQuizLoader.loadFromAsset(
                          'assets/quiz/questions.xlsx',
                        );
                        if (!context.mounted) return;

                        if (questions.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Aucune question trouvée dans le fichier Excel.',
                              ),
                            ),
                          );
                          return; // stay on intro
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                QuizPlayScreen(questions: questions),
                          ),
                        );
                      },
                    ),
                    _CategoryCard(
                      icon: Icons.policy_rounded,
                      title: 'Normes / NEP',
                      subtitle: 'Bientôt',
                      disabled: true,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<QuizQuestion>> _loadQuestions(BuildContext context) async {
    try {
      return await ExcelQuizLoader.loadFromAsset('assets/quiz/questions.xlsx');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur chargement quiz: $e')));
      }
      return [];
    }
  }
}

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool disabled;

  const _CategoryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {

   
    final cs = Theme.of(context).colorScheme;
    final disabledColor = cs.onSurface.withOpacity(0.3);

 

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: disabled ? null : onTap,
        borderRadius: BorderRadius.circular(20),
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
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: disabled ? disabledColor : cs.onPrimaryContainer,
                ),
              ),
              const Spacer(),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: disabled ? disabledColor : null,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: disabled
                      ? disabledColor
                      : Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// --------- Ecran de jeu ----------
class QuizPlayScreen extends StatefulWidget {
  final List<QuizQuestion> questions;

  const QuizPlayScreen({super.key, required this.questions});

  @override
  State<QuizPlayScreen> createState() => _QuizPlayScreenState();
}

class _QuizPlayScreenState extends State<QuizPlayScreen> {
  int index = 0;
  int? selected; // 0..3
  int score = 0;

void _showResult() {
  // 🎉 Perfect run → celebrate
  // if (score == widget.questions.length && widget.questions.isNotEmpty) {
  //   _celebratePerfect();
  // }

  // For testing: celebrate if there's at least 1 correct answer
  final bool celebrate = score >= 1 && widget.questions.isNotEmpty;
  if (celebrate) {
    _celebratePerfect();
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      final cs = Theme.of(context).colorScheme;
      final perfect = score == widget.questions.length && widget.questions.isNotEmpty;
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: cs.primaryContainer,
                child: Icon(
                  perfect ? Icons.stars_rounded : Icons.emoji_events_rounded,
                  color: cs.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                perfect ? 'Parfait !' : 'Quiz terminé',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Text('Score: $score/${widget.questions.length}'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context); // close dialog
                  Navigator.pop(context); // back to intro
                },
                child: const Text('Rejouer'),
              ),
            ],
          ),
        ),
      );
    },
  );
}


void _celebratePerfect() {
  final overlay = Overlay.of(context);
  if (overlay == null) return;

  // Controllers for each emitter
  final left = ConfettiController(duration: const Duration(seconds: 3));
  final center = ConfettiController(duration: const Duration(seconds: 3));
  final right = ConfettiController(duration: const Duration(seconds: 3));

  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) {
      final cs = Theme.of(context).colorScheme;
      return Positioned.fill(
        child: IgnorePointer(
          child: Stack(
            children: [
              // Left
              Align(
                alignment: const Alignment(-0.9, -1.0),
                child: ConfettiWidget(
                  confettiController: left,
                  blastDirection: math.pi / 2, // down
                  blastDirectionality: BlastDirectionality.directional,
                  emissionFrequency: 0.03,
                  numberOfParticles: 6,
                  gravity: 0.65, // fall speed
                  maxBlastForce: 18,
                  minBlastForce: 12,
                  colors: [cs.primary, cs.secondary, cs.tertiary, cs.error],
                ),
              ),
              // Center
              Align(
                alignment: const Alignment(0.0, -1.0),
                child: ConfettiWidget(
                  confettiController: center,
                  blastDirection: math.pi / 2, // down
                  blastDirectionality: BlastDirectionality.directional,
                  emissionFrequency: 0.045,
                  numberOfParticles: 8,
                  gravity: 0.7,
                  maxBlastForce: 20,
                  minBlastForce: 12,
                  colors: [cs.primary, cs.secondary, cs.tertiary, cs.error],
                ),
              ),
              // Right
              Align(
                alignment: const Alignment(0.9, -1.0),
                child: ConfettiWidget(
                  confettiController: right,
                  blastDirection: math.pi / 2, // down
                  blastDirectionality: BlastDirectionality.directional,
                  emissionFrequency: 0.03,
                  numberOfParticles: 6,
                  gravity: 0.65,
                  maxBlastForce: 18,
                  minBlastForce: 12,
                  colors: [cs.primary, cs.secondary, cs.tertiary, cs.error],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  overlay.insert(entry);
  left.play();
  center.play();
  right.play();

  // stop & clean
  Future.delayed(const Duration(seconds: 3), () {
    left.stop();
    center.stop();
    right.stop();
    left.dispose();
    center.dispose();
    right.dispose();
    entry.remove();
  });
}


  // Timer (ex: 25 sec/question)
  static const int perQuestion = 25;
  late int timeLeft;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timeLeft = perQuestion;
    _startTimer();
  }

  void _startTimer() {
    timer?.cancel();
    timeLeft = perQuestion;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (timeLeft <= 0) {
        _lockAnswer(null); // temps écoulé
        return;
      }
      setState(() => timeLeft--);
    });
  }

  void _lockAnswer(int? option) {
    timer?.cancel();
    final q = widget.questions[index];

    setState(() => selected = option);
    if (option != null && option == q.correctIndex) score++;

    // petite pause avant la question suivante
    Future.delayed(const Duration(milliseconds: 650), _next);
  }

  void _next() {
    if (index + 1 >= widget.questions.length) {
      _showResult();
      return;
    }
    setState(() {
      index++;
      selected = null;
    });
    _startTimer();
  }



  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: const Center(child: Text('Aucune question disponible.')),
      );
    }
    final cs = Theme.of(context).colorScheme;
    final q = widget.questions.isEmpty
        ? QuizQuestion(
            question: 'Aucune question trouvée.',
            options: const ['—', '—', '—', '—'],
            correctIndex: 0,
          )
        : widget.questions[index];

    final progress = widget.questions.isEmpty
        ? 0.0
        : (index + 1) / widget.questions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _TimerChip(seconds: timeLeft),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              cs.primary.withOpacity(0.08),
              cs.secondary.withOpacity(0.08),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            // progress top
            Row(
              children: [
                Text(
                  '${index + 1}/${widget.questions.isEmpty ? 0 : widget.questions.length}',
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // question card
            _QuestionCard(text: q.question),

            const SizedBox(height: 16),

            // options
            for (int i = 0; i < q.options.length; i++)
              _AnswerTile(
                indexLabel: String.fromCharCode(65 + i), // A/B/C/D
                text: q.options[i],
                state: _tileState(i, q.correctIndex),
                onTap: selected == null ? () => _lockAnswer(i) : null,
              ),
          ],
        ),
      ),
    );
  }

  _AnswerState _tileState(int i, int correct) {
    if (selected == null) return _AnswerState.idle;
    if (i == selected && i == correct) return _AnswerState.correct;
    if (i == selected && i != correct) return _AnswerState.wrong;
    if (i == correct) return _AnswerState.reveal;
    return _AnswerState.idleDimmed;
  }
}

class _TimerChip extends StatelessWidget {
  final int seconds;
  const _TimerChip({required this.seconds});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.timer, size: 16, color: cs.onPrimaryContainer),
          const SizedBox(width: 6),
          Text(
            '$seconds s',
            style: TextStyle(
              color: cs.onPrimaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final String text;
  const _QuestionCard({required this.text});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: cs.outlineVariant.withOpacity(0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline_rounded, color: cs.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

enum _AnswerState { idle, idleDimmed, correct, wrong, reveal }

class _AnswerTile extends StatelessWidget {
  final String indexLabel;
  final String text;
  final _AnswerState state;
  final VoidCallback? onTap;

  const _AnswerTile({
    required this.indexLabel,
    required this.text,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Color bg = cs.surface;
    Color border = cs.outlineVariant.withOpacity(0.35);
    Color? tick;
    switch (state) {
      case _AnswerState.correct:
      case _AnswerState.reveal:
        bg = Colors.green.withOpacity(0.18);
        border = Colors.green.withOpacity(0.55);
        tick = Colors.green.shade700;
        break;
      case _AnswerState.wrong:
        bg = Colors.red.withOpacity(0.18);
        border = Colors.red.withOpacity(0.55);
        tick = Colors.red.shade700;
        break;
      case _AnswerState.idleDimmed:
        bg = cs.surface.withOpacity(0.8);
        break;
      case _AnswerState.idle:
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                _IndexBall(label: indexLabel),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                if (tick != null)
                  Icon(
                    state == _AnswerState.wrong
                        ? Icons.close_rounded
                        : Icons.check_rounded,
                    color: tick,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IndexBall extends StatelessWidget {
  final String label;
  const _IndexBall({required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: cs.onPrimaryContainer,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
