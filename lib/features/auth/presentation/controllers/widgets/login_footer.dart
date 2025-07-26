import 'package:chkoba_tn/core/constants/app_colors.dart';
import 'package:chkoba_tn/core/constants/app_strings.dart';
import 'package:flutter/material.dart';


class LoginFooter extends StatelessWidget {
  final VoidCallback onTermsTap;
  final VoidCallback onPrivacyTap;

  const LoginFooter({
    Key? key,
    required this.onTermsTap,
    required this.onPrivacyTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppStrings.byContinuing,
          style: TextStyle(
            color: AppColors.whiteOpacity(0.8),
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: onTermsTap,
              child: const Text(
                AppStrings.terms,
                style: TextStyle(
                  color: AppColors.gold,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Text(
              AppStrings.and,
              style: TextStyle(
                color: AppColors.whiteOpacity(0.8),
                fontSize: 10,
              ),
            ),
            InkWell(
              onTap: onPrivacyTap,
              child: const Text(
                AppStrings.privacy,
                style: TextStyle(
                  color: AppColors.gold,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
