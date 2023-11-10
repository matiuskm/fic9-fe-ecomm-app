// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final String label;
  final Function(T?)? onChanged;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.label,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<T>(
            value: value,
            onChanged: onChanged,
            isExpanded: true,
            items: items.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(item!.toString()),
              );
            }).toList(),
            hint: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
