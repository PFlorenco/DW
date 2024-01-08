import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

class DeliveryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final double? height;

  const DeliveryButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.width,
      this.height = 50});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: context.textStyles.textExtraBold
              .copyWith(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
