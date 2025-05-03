import 'package:flutter/material.dart';
import 'package:medical/Constants/responsive_utils.dart';

/// A responsive bottom navigation bar that adapts to different screen sizes
class ResponsiveBottomNavBar extends StatelessWidget {
  /// The currently selected index
  final int currentIndex;
  
  /// Function to call when an item is tapped
  final ValueChanged<int>? onTap;
  
  /// The height of the navigation bar (will be adjusted for responsiveness)
  final double height;
  
  /// The items to display in the navigation bar
  final List<ResponsiveBottomNavItem> items;
  
  /// Whether to show a notch for a floating action button
  final bool showNotch;
  
  const ResponsiveBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    this.onTap,
    this.height = 60.0,
    this.showNotch = true,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final barHeight = responsive.getResponsiveSize(height);
    
    return BottomAppBar(
      height: barHeight,
      shape: showNotch ? const CircularNotchedRectangle() : null,
      notchMargin: responsive.getResponsiveSize(8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isSelected = index == currentIndex;
          
          return Expanded(
            child: InkWell(
              onTap: () => onTap?.call(index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.icon,
                    color: isSelected ? const Color(0xff0B8FAC) : Colors.grey,
                    size: responsive.getResponsiveSize(24),
                  ),
                  if (item.label != null) ...[
                    SizedBox(height: responsive.getResponsiveSize(4)),
                    Text(
                      item.label!,
                      style: TextStyle(
                        color: isSelected ? const Color(0xff0B8FAC) : Colors.grey,
                        fontSize: responsive.fontSize(12),
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// A class representing an item in the bottom navigation bar
class ResponsiveBottomNavItem {
  /// The icon to display
  final IconData icon;
  
  /// The label to display (optional)
  final String? label;
  
  const ResponsiveBottomNavItem({
    required this.icon,
    this.label,
  });
}
