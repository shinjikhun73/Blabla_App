import 'package:flutter/material.dart';

import '../../../model/ride/locations.dart';
import '../../../theme/theme.dart';

class LocationInputTile extends StatelessWidget {
  final String placeholder;
  final Location? value;
  final VoidCallback onTap;
  final Widget? trailing;

  const LocationInputTile({
    super.key,
    required this.placeholder,
    required this.value,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: BlaColors.textLight,
      title: Text(
        value?.name ?? placeholder,
        style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
      ),
      leading: const Icon(Icons.circle_outlined, color: Colors.blueGrey),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
