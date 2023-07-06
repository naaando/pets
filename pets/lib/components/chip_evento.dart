import 'package:flutter/material.dart';

class ChipEvento extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const ChipEvento({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
  });

  factory ChipEvento.parse(String label) {
    switch (label) {
      case 'vacina':
        return ChipEvento.vacina();
      case 'medicacao':
        return ChipEvento.medicacao();
      default:
        return ChipEvento.vacina();
    }
  }

  factory ChipEvento.vacina() => const ChipEvento(
        label: 'Vacina',
        icon: Icons.vaccines,
        color: Colors.purple,
      );

  factory ChipEvento.medicacao() {
    return const ChipEvento(
      label: 'Medicação',
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
