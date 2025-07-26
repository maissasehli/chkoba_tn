import 'package:chkoba_tn/core/constants/app_colors.dart';
import 'package:chkoba_tn/core/constants/app_dimensions.dart';
import 'package:chkoba_tn/core/constants/app_strings.dart';
import 'package:flutter/material.dart';


class GuestButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;

  const GuestButton({
    Key? key,
    this.onPressed,
    this.isLoading = false,
    this.height = 38.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: TextButton(
        onPressed: isLoading ? null : onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radius8),
          ),
        ),
        child: const Text(
          AppStrings.continueAsGuest,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
