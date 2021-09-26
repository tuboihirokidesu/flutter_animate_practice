import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage()));

class _MyHeader {
  const _MyHeader(this.title, this.visible);

  final String title;
  final bool visible;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final headerNotifier = ValueNotifier<_MyHeader?>(null);
  final scrollNotifier = ValueNotifier(0.0);
  final scrollController = ScrollController();

  final double _cardHeaderSize = 250;

  void _refreshHeader(String title, bool visible, {String? lastOne}) {
    final headerValue = headerNotifier.value;
    final headerTitle = headerValue?.title ?? title;
    final headerVisible = headerValue?.visible ?? false;

    if (scrollController.offset > 0 &&
        (headerTitle != title || lastOne != null || headerVisible != visible)) {
      Future.microtask(() {
        if (!visible && lastOne != null) {
          headerNotifier.value = _MyHeader(lastOne, true);
        } else {
          headerNotifier.value = _MyHeader(title, visible);
        }
      });
    }
  }

  void _onList() {
    scrollNotifier.value = scrollController.offset;
  }

  @override
  void initState() {
    scrollController.addListener(_onList);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(_onList);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              controller: scrollController,
              slivers: <Widget>[
                ValueListenableBuilder<double>(
                    valueListenable: scrollNotifier,
                    builder: (context, snapshot, _) {
                      final space = _cardHeaderSize - kToolbarHeight;
                      final percent = lerpDouble(
                          0.0, -pi / 2, (snapshot / space).clamp(0.0, 1.0))!;
                      final opacity = lerpDouble(
                          1.0, 0.0, (snapshot / space).clamp(0.0, 1.0))!;
                      return SliverAppBar(
                        centerTitle: false,
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.transparent,
                        title: const Text(
                          '\$26.710',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        expandedHeight: _cardHeaderSize,
                        stretch: true,
                        flexibleSpace: FlexibleSpaceBar(
                          stretchModes: const [StretchMode.blurBackground],
                          background: Padding(
                            padding: const EdgeInsets.only(
                              top: kToolbarHeight,
                            ),
                            child: Center(
                              child: Opacity(
                                opacity: opacity,
                                child: Transform(
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.003)
                                    ..rotateX(percent),
                                  alignment: Alignment.center,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    children: [
                                      Container(
                                        color: Colors.red,
                                        width: 150,
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        color: Colors.blue,
                                        width: 120,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                ...[
                  SliverPersistentHeader(
                    delegate: _MyHeadertitle(
                      'Header',
                      (visible) => _refreshHeader(
                        'January',
                        visible,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final int = index + 1;
                        return ListTile(
                            title: Text('Day $int',
                                style: const TextStyle(color: Colors.white)));
                      },
                      childCount: 31,
                    ),
                  )
                ],
                ...[
                  SliverPersistentHeader(
                    delegate: _MyHeadertitle(
                      'Header',
                      (visible) => _refreshHeader(
                        'February',
                        visible,
                        lastOne: 'January',
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final int = index + 1;
                        return ListTile(
                            title: Text('Day $int',
                                style: const TextStyle(color: Colors.white)));
                      },
                      childCount: 28,
                    ),
                  )
                ],
                ...[
                  SliverPersistentHeader(
                    delegate: _MyHeadertitle(
                      'Header',
                      (visible) => _refreshHeader(
                        'Merch',
                        visible,
                        lastOne: 'February',
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final int = index + 1;
                        return ListTile(
                            title: Text('Day $int',
                                style: const TextStyle(color: Colors.white)));
                      },
                      childCount: 31,
                    ),
                  )
                ],
                ...[
                  SliverPersistentHeader(
                    delegate: _MyHeadertitle(
                      'Header',
                      (visible) => _refreshHeader(
                        'April',
                        visible,
                        lastOne: 'Merch',
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final int = index + 1;
                        return ListTile(
                            title: Text('Day $int',
                                style: const TextStyle(color: Colors.white)));
                      },
                      childCount: 30,
                    ),
                  )
                ],
                ...[
                  SliverPersistentHeader(
                    delegate: _MyHeadertitle(
                      'Header',
                      (visible) => _refreshHeader(
                        'May',
                        visible,
                        lastOne: 'April',
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final int = index + 1;
                        return ListTile(
                            title: Text('Day $int',
                                style: const TextStyle(color: Colors.white)));
                      },
                      childCount: 31,
                    ),
                  )
                ],
                ...[
                  SliverPersistentHeader(
                    delegate: _MyHeadertitle(
                      'Header',
                      (visible) => _refreshHeader(
                        'June',
                        visible,
                        lastOne: 'May',
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final int = index + 1;
                        return ListTile(
                            title: Text('Day $int',
                                style: const TextStyle(color: Colors.white)));
                      },
                      childCount: 30,
                    ),
                  )
                ],
                ...[
                  SliverPersistentHeader(
                    delegate: _MyHeadertitle(
                      'Header',
                      (visible) => _refreshHeader(
                        'July',
                        visible,
                        lastOne: 'June',
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final int = index + 1;
                        return ListTile(
                            title: Text('Day $int',
                                style: const TextStyle(color: Colors.white)));
                      },
                      childCount: 31,
                    ),
                  )
                ],
                ...[
                  SliverPersistentHeader(
                    delegate: _MyHeadertitle(
                      'Header',
                      (visible) => _refreshHeader(
                        'August',
                        visible,
                        lastOne: 'July',
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final int = index + 1;
                        return ListTile(
                            title: Text('Day $int',
                                style: const TextStyle(color: Colors.white)));
                      },
                      childCount: 31,
                    ),
                  )
                ],
              ],
            ),
            ValueListenableBuilder<_MyHeader?>(
                valueListenable: headerNotifier,
                builder: (context, snapshot, _) {
                  final visible = snapshot?.visible ?? false;
                  final title = snapshot?.title ?? '';
                  return Positioned(
                      top: 0,
                      left: 15,
                      right: 0,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        layoutBuilder: (currentChild, previousChildren) {
                          return Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              ...previousChildren,
                              if (currentChild != null) currentChild,
                            ],
                          );
                        },
                        transitionBuilder: (widget, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SizeTransition(
                                sizeFactor: animation, child: widget),
                          );
                        },
                        child: visible
                            ? DecoratedBox(
                                key: Key(title),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7)),
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ));
                })
          ],
        ),
      ),
    );
  }
}

class _MyHeadertitle extends SliverPersistentHeaderDelegate {
  const _MyHeadertitle(this.title, this.onHeaderChanged);

  final String title;
  final void Function(bool visible) onHeaderChanged;
  @override
  double get minExtent => 55;

  @override
  double get maxExtent => 55;

  @override
  bool shouldRebuild(covariant oldDelegate) => false;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (shrinkOffset > 0) {
      onHeaderChanged(true);
    } else {
      onHeaderChanged(false);
    }

    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
