import 'package:flutter/material.dart';

class HomeTab {
  const HomeTab({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.screen,
    this.badge = 0,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final Widget screen;
  final int badge;
}

/// Bottom navigation over full screens. Each tab keeps its own state
/// (scroll position, open sheet) while another tab is shown.
class HomeScaffold extends StatefulWidget {
  const HomeScaffold({super.key, required this.tabs});

  final List<HomeTab> tabs;

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [for (final t in widget.tabs) t.screen],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        backgroundColor: scheme.surfaceContainerLow,
        destinations: [
          for (final t in widget.tabs)
            NavigationDestination(
              icon: Badge(
                label: Text('${t.badge}'),
                isLabelVisible: t.badge > 0,
                child: Icon(t.icon),
              ),
              selectedIcon: Badge(
                label: Text('${t.badge}'),
                isLabelVisible: t.badge > 0,
                child: Icon(t.selectedIcon),
              ),
              label: t.label,
            ),
        ],
      ),
    );
  }
}
