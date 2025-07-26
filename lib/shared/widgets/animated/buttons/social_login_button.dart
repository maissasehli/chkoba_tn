import 'package:chkoba_tn/core/constants/app_colors.dart';
import 'package:chkoba_tn/core/constants/app_dimensions.dart';
import 'package:flutter/material.dart';


class SocialLoginButton extends StatelessWidget {
  final String provider;
  final String label;
  final Widget icon;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isOutlined;
  final double height;

  const SocialLoginButton({
    Key? key,
    required this.provider,
    required this.label,
    required this.icon,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.isOutlined = false,
    this.height = AppDimensions.buttonHeightMedium,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget buttonIcon = isLoading
        ? SizedBox(
            width: AppDimensions.iconSmall,
            height: AppDimensions.iconSmall,
            child: CircularProgressIndicator(
              color: foregroundColor ?? AppColors.white,
              strokeWidth: 2,
            ),
          )
        : icon;

    final String buttonLabel = isLoading ? 'Connexion...' : label;

    if (isOutlined) {
      return SizedBox(
        width: double.infinity,
        height: height,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.white,
            foregroundColor: foregroundColor ?? AppColors.grey900,
            side: const BorderSide(color: AppColors.grey300, width: 1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radius10),
            ),
          ),
          icon: buttonIcon,
          label: Text(
            buttonLabel,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor ?? AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radius10),
          ),
        ),
        icon: buttonIcon,
        label: Text(
          buttonLabel,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}