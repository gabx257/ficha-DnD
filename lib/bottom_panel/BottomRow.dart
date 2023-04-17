import 'package:flutter/material.dart';

import '../core/shadowbox.dart';

class BottomRow extends StatelessWidget {
  const BottomRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: ShadowBox(
            height: 200,
            children: [Text("Abilities")],
          ),
        ),
        Expanded(
          child: ShadowBox(
            height: 200,
            children: [Text("Languages Tool Proficiencies")],
          ),
        )
      ],
    );
  }
}
