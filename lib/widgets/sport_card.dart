import 'package:flutter/material.dart';

import '../models/dashboard_item.dart';

class SportCard extends StatelessWidget {
  const SportCard({super.key, required this.sport, required this.onTap, this.isSelected = false, this.showDescription = false});

  final SportOption sport;
  final VoidCallback onTap;
  final bool isSelected;
  final bool showDescription;

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        selected: isSelected,
        label: '${sport.name}. ${sport.description}${isSelected ? '. Selected' : ''}',
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: BorderSide(color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent, width: 2)),
          color: isSelected ? Theme.of(context).colorScheme.primary.withValues(alpha: .08) : null,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(width: showDescription ? 52 : 40, height: showDescription ? 52 : 40, decoration: BoxDecoration(color: sport.color, borderRadius: BorderRadius.circular(13)), child: Icon(sport.icon, color: const Color(0xFF176B45), size: showDescription ? 27 : 21)),
              SizedBox(height: showDescription ? 14 : 9),
              Text(sport.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium),
              if (showDescription) ...[const SizedBox(height: 6), Text(sport.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium)],
            ]),
          ),
          ),
        ),
      );
}