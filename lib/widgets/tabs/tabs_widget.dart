import 'package:flutter/material.dart';

class TabsWidget extends StatelessWidget {
  final PreferredSizeWidget appBar;
  final List<Widget> children;
  final int? length;
  final int? index;
  const TabsWidget(
      {super.key,
      required this.appBar,
      this.length,
      required this.children,
      this.index});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: index ?? 0,
      length: length ?? 2, // Number of tabs
      child: Scaffold(
        appBar: appBar,
        body: TabBarView(
          children: children,
        ),
      ),
    );
  }
}
