import 'package:flutter/material.dart';

class GCMainContainer extends StatelessWidget {
  const GCMainContainer({
    super.key,
    required this.scrollable,
    required this.children,
  });
  final bool scrollable;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(16),
        child: scrollable
            ? SingleChildScrollView(
                child: Column(
                  children: children,
                ),
              )
            : Column(
                children: children,
              ),
      ),
    );
  }
}
