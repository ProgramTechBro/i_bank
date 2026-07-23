import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.obscureText = false,
    this.showObscureToggle = false,
    this.readOnly = false,
    this.keyboardType,
    this.onChanged,
    this.onToggleObscure,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final bool obscureText;
  final bool showObscureToggle;
  final bool readOnly;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onToggleObscure;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: textTheme.labelSmall?.copyWith(color: AppColors.neutral500),
          ),
          const SizedBox(height: 8),
        ],
        SizedBox(
          height: 44,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            readOnly: readOnly,
            keyboardType: keyboardType,
            onChanged: onChanged,
            style: textTheme.labelLarge?.copyWith(color: AppColors.neutral900),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: textTheme.labelLarge?.copyWith(
                color: AppColors.neutral300,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: AppColors.neutral300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
              suffixIcon: showObscureToggle
                  ? IconButton(
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 18,
                        color: AppColors.neutral300,
                      ),
                      onPressed: onToggleObscure,
                    )
                  : suffixIcon != null
                  ? Icon(suffixIcon, size: 18, color: AppColors.neutral300)
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
