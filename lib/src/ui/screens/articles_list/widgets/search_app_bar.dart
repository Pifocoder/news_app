import 'package:flutter/material.dart';

import '../../../navigator/manager.dart';
import 'heart_icon.dart';

const double kMinHeightAppBar = 120;
const double kMaxHeightAppBar = 200;

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {
  final NavigatorManager navigatorManager;
  final String queryName;
  final Map<String, String> activeQuery;
  final void Function(String queryName, String queryValue) updateActiveQuery;

  SliverSearchAppBar(
      {required this.queryName,
      required this.activeQuery,
      required this.updateActiveQuery,
      required this.navigatorManager});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
        height: kMaxHeightAppBar,
        child: ClipPath(
            clipper: SliverSearchAppBarClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.black87],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 30, right: 10),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: SearchBar(
                          padding: const MaterialStatePropertyAll<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 16.0)),
                          leading: const Icon(Icons.search),
                          onSubmitted: (value) {
                            updateActiveQuery(queryName, value);
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: AnimatedFavoriteIconButton(
                            navigatorManager: navigatorManager),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }

  @override
  double get maxExtent => kMaxHeightAppBar;

  @override
  double get minExtent => kMinHeightAppBar;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}

class SliverSearchAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var heightDelta = (size.height - kMinHeightAppBar) * 0.7;
    var controlPoint1 = Offset(0, size.height);
    var controlPoint2 = Offset(size.width, size.height);
    var endPoint = Offset(size.width, size.height - heightDelta);

    Path path = Path()
      ..lineTo(0, size.height - heightDelta)
      ..cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
          controlPoint2.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
