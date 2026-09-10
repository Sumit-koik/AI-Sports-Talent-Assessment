import 'package:flutter/material.dart';

class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 64});

  final double size;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer, borderRadius: BorderRadius.circular(size * .28)),
        child: Stack(alignment: Alignment.center, children: [
          Icon(Icons.track_changes_rounded, size: size * .58, color: Theme.of(context).colorScheme.primary),
          Positioned(right: size * .19, top: size * .19, child: Icon(Icons.bolt_rounded, size: size * .23, color: Theme.of(context).colorScheme.primary)),
        ]),
      );
}