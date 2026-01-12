import '../models/navigation_item.dart';
import 'navigation_constants.dart';
import 'navigation_labels.dart';

class BottomNavigationConstants {
  BottomNavigationConstants._();

  static const List<NavigationItem> navigationItems = [
    NavigationItem(
      iconPath: '',
      label: NavigationLabels.home,
      route: NavigationConstants.home,
    ),
    NavigationItem(
      iconPath: '',
      label: NavigationLabels.favorites,
      route: NavigationConstants.favorites,
    ),
    NavigationItem(
      iconPath: '',
      label: NavigationLabels.game,
      route: NavigationConstants.game,
    ),
    NavigationItem(
      iconPath: '',
      label: NavigationLabels.profile,
      route: NavigationConstants.profile,
    ),
  ];
}
