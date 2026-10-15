import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../mini_games/presentation/controllers/mini_games_controller.dart';
import '../controllers/advent_storybook_controller.dart';
import '../../domain/models/advent_chapter.dart';
import '../../domain/models/advent_chapter_status.dart';
import '../widgets/storybook_chapter_card.dart';
import '../widgets/storybook_cover_header.dart';
import 'advent_chapter_reader_screen.dart';

class AdventStorybookScreen extends StatefulWidget {
  final AdventStorybookController? controller;
  final MiniGamesController? gamesController;

  const AdventStorybookScreen({
    super.key,
    this.controller,
    this.gamesController,
  });

  @override
  State<AdventStorybookScreen> createState() => _AdventStorybookScreenState();
}

class _AdventStorybookScreenState extends State<AdventStorybookScreen> {
  late final AdventStorybookController _controller;
  late final MiniGamesController _gamesController;
  late final bool _internalController;
  late final bool _internalGamesController;

  @override
  void initState() {
    super.initState();
    if (widget.gamesController != null) {
      _gamesController = widget.gamesController!;
      _internalGamesController = false;
    } else {
      _gamesController = MiniGamesController();
      _internalGamesController = true;
      _gamesController.initialize();
    }

    if (widget.controller != null) {
      _controller = widget.controller!;
      _internalController = false;
    } else {
      _controller = AdventStorybookController(
        gamesController: _gamesController,
      );
      _internalController = true;
      _controller.initialize();
    }
  }

  @override
  void dispose() {
    if (_internalController) {
      _controller.dispose();
    }
    if (_internalGamesController) {
      _gamesController.dispose();
    }
    super.dispose();
  }

  void _onChapterTap(
    BuildContext context,
    AdventChapter chapter,
    AdventChapterStatus status,
  ) {
    if (status == AdventChapterStatus.locked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${chapter.title}: ${chapter.unlockRuleDescription}'),
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AdventChapterReaderScreen(
          chapter: chapter,
          controller: _controller,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.adventScreenTitle)),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final state = _controller.state;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580),
                child: ListView.separated(
                  padding: const EdgeInsets.all(AppDimensions.spaceLG),
                  itemCount: state.chapters.length + 1,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppDimensions.spaceSM),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppDimensions.spaceMD,
                        ),
                        child: StorybookCoverHeader(state: state),
                      );
                    }

                    final chapter = state.chapters[index - 1];
                    final status = state.getChapterStatus(chapter.dayNumber);

                    return StorybookChapterCard(
                      key: Key('chapter_card_${chapter.dayNumber}'),
                      chapter: chapter,
                      status: status,
                      onTap: () => _onChapterTap(context, chapter, status),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
