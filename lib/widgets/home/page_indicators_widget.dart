import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageIndicatorsWidget extends StatelessWidget {
  final RxInt currentPage;
  final Function(int) onPageChanged;

  const PageIndicatorsWidget({
    Key? key,
    required this.currentPage,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPageIndicator(0, 'Jeux', Icons.games),
        const SizedBox(width: 24),
        _buildPageIndicator(1, 'Profil', Icons.person),
        const SizedBox(width: 24),
        _buildPageIndicator(2, 'Paramètres', Icons.settings),
      ],
    ));
  }

  Widget _buildPageIndicator(int index, String title, IconData icon) {
    final isActive = currentPage.value == index;
    return GestureDetector(
      onTap: () => onPageChanged(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive 
            ? Colors.white.withOpacity(0.2)
            : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive 
              ? Colors.white.withOpacity(0.5)
              : Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
