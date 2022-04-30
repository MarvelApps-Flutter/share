import 'package:flutter/material.dart';
class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay({Key? key, this.value = 0})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_outlined,
          color: index < value ? Colors.blueAccent.shade700 : Colors.black,
          size: 20,
        );
      }),
    );
  }
}