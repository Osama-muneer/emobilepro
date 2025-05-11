import 'package:flutter/material.dart';

class RightSideNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const RightSideNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight, // محاذاة الشريط لليمين
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_navItems.length, (index) {
            final item = _navItems[index];
            return GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? Colors.red.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      color:
                      currentIndex == index ? Colors.red : Colors.grey,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.title,
                      style: TextStyle(
                        color:
                        currentIndex == index ? Colors.red : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// تعريف عنصر التنقل الذي يحتوي على أيقونة واسم
class NavigationItem {
  final IconData icon;
  final String title;

  NavigationItem({required this.icon, required this.title});
}

// قائمة بعناصر التنقل
final List<NavigationItem> _navItems = [
  NavigationItem(icon: Icons.home, title: 'الرئيسية'),
  NavigationItem(icon: Icons.search, title: 'بحث'),
  NavigationItem(icon: Icons.favorite, title: 'مفضلة'),
];
