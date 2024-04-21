import 'package:flutter/material.dart';

import '../../../navigator/manager.dart';
import '../articles_list_screen.dart';

class AnimatedFavoriteIconButton extends StatelessWidget {
  final NavigatorManager navigatorManager;

  const AnimatedFavoriteIconButton({super.key,
    required this.navigatorManager,
  });

  @override
  Widget build(BuildContext context) {
    final controller = AnimationControllerProvider.of(context)!.controller;
    return AnimatedBuilder(
      animation: CurvedAnimation(
        parent: controller,
        curve: Curves.decelerate,
      ),
      builder: (buildContext, child) {
        final double bounceValue = controller.value *
            15.0;

        return Transform.translate(
          offset: Offset(0.0, -bounceValue.abs()), child: IconButton(
          icon: const Icon(
            color: Colors.white,
            Icons.favorite,
            size: 55,
          ),
          onPressed: () {
            navigatorManager.goToFavouriteArticlesScreen(context);
          },
        ));
      },
    );
  }
}
