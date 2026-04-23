import 'package:go_router/go_router.dart';
import 'package:simple_weather/pages/graph_page/graph_page.dart';
import 'package:simple_weather/pages/home_page/home_page.dart';
import 'package:simple_weather/pages/settings_page/settings_page.dart';
import 'package:simple_weather/pages/stats_page/stats_page.dart';
import 'package:simple_weather/services/routes/navigation_shell.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NavShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/home', builder: (context, state) => HomePage()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/graph', builder: (context, state) => GraphPage()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/stats', builder: (context, state) => StatsPage()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => SettingsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
