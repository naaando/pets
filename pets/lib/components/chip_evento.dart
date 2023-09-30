import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pets/translate.dart';

class ChipEvento extends HookWidget {
  final String label;
  final IconData icon;
  final Color color;

  const ChipEvento({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
  });

  factory ChipEvento.parse(BuildContext context, String label) {
    switch (label) {
      case 'vacina':
        return ChipEvento.vacina(context);
      case 'medicacao':
        return ChipEvento.medicacao(context);
      default:
        return ChipEvento.vacina(context);
    }
  }

  factory ChipEvento.vacina(BuildContext context) {
    return ChipEvento(
      label: t().vaccine,
      icon: Icons.vaccines,
      color: Colors.purple,
    );
  }

  factory ChipEvento.medicacao(BuildContext context) {
    return ChipEvento(
      label: t().medication,
      icon: Icons.medical_services,
      color: Colors.green,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18,
      child: Chip(
        backgroundColor: color,
        avatar: Icon(icon, size: 10, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(fontSize: 10, color: Colors.white),
        ),
        visualDensity: VisualDensity.compact,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        padding: const EdgeInsets.only(bottom: 8),
        labelPadding: const EdgeInsets.only(right: 8),
      ),
    );
  }
}
