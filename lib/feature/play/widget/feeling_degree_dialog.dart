import 'package:flutter/material.dart';

import 'image_card.dart';

class FeelingDegreeDialog extends StatefulWidget {
  final Function(String) setSatisfaction;

  const FeelingDegreeDialog({super.key, required this.setSatisfaction});

  @override
  State<FeelingDegreeDialog> createState() => _FeelingDegreeDialogState();
}

class _FeelingDegreeDialogState extends State<FeelingDegreeDialog>
    with TickerProviderStateMixin {
  late TabController _tabController;

  static List<ImageCard> imageCards = <ImageCard>[
    const ImageCard(
      image: Image(
        image: AssetImage('assets/image/feeling/happy.png'),
      ),
      satisfaction: 'happy',
    ),
    const ImageCard(
      image: Image(
        image: AssetImage('assets/image/feeling/sad.png'),
      ),
      satisfaction: 'sad',
    ),
    const ImageCard(
      image: Image(
        image: AssetImage('assets/image/feeling/angry.png'),
      ),
      satisfaction: 'angry',
    ),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: imageCards.length);
    _tabController.addListener(() {
      int index = _tabController.index;
      String satisfaction = imageCards[index].satisfaction;
      widget.setSatisfaction(satisfaction);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 320,
      child: Column(
        children: [
          Expanded(
            // TabBarView를 Expanded로 감싸줍니다.
            child: TabBarView(
              controller: _tabController,
              children: imageCards.map((imageCard) => imageCard).toList(),
            ),
          ),
          TabPageSelector(
            controller: _tabController,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            selectedColor: Theme.of(context).colorScheme.error,
          ),
        ],
      ),
    );
  }
}
