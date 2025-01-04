import 'package:flutter/material.dart';

class WidgetButtonEndereco extends StatelessWidget {
  final VoidCallback vfn;

  const WidgetButtonEndereco({
    required this.vfn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: vfn,
              label: const Text('Novo endereço'),
              icon: const Icon(Icons.add_location),
            ),
          ),
        ],
      ),
    );
  }
}
