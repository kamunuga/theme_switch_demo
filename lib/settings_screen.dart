import 'package:flutter/material.dart';

/// A typical app settings screen. The "Dark mode" Switch is the widget
/// being demonstrated; the bottom section lets the presenter turn three
/// Switch properties on and off live to compare them with the defaults.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Ordinary settings, so the screen looks like a real app.
  bool _notifications = true;

  // Presenter panel: when false, the Switch uses Flutter's default value.
  bool _useCustomActiveTrackColor = false;
  bool _useCustomInactiveThumbColor = false;
  bool _useThumbIcon = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const _SectionHeader('Appearance'),
          ListTile(
            leading: Icon(
              widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            title: const Text('Dark mode'),
            subtitle: Text(
              widget.isDarkMode ? 'Dark theme is on' : 'Light theme is on',
            ),
            // ---------- The widget being demonstrated ----------
            trailing: Switch(
              // value: whether the switch is on (dark) or off (light).
              value: widget.isDarkMode,
              // onChanged: called with the new value when the user taps it.
              onChanged: widget.onDarkModeChanged,

              // Property 1: track colour when ON. null = theme's primary colour.
              activeTrackColor:
                  _useCustomActiveTrackColor ? Colors.amber : null,

              // Property 2: thumb colour when OFF. null = theme's outline colour.
              inactiveThumbColor:
                  _useCustomInactiveThumbColor ? Colors.deepOrange : null,

              // Property 3: icon drawn inside the thumb. null = no icon.
              thumbIcon: _useThumbIcon
                  ? WidgetStateProperty.resolveWith<Icon?>((states) {
                      if (states.contains(WidgetState.selected)) {
                        return const Icon(Icons.dark_mode);
                      }
                      return const Icon(Icons.light_mode);
                    })
                  : null,
            ),
            // ---------------------------------------------------
          ),

          const _SectionHeader('Notifications'),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_outlined),
            title: const Text('Push notifications'),
            value: _notifications,
            onChanged: (value) => setState(() => _notifications = value),
          ),

          const Divider(height: 32),
          const _SectionHeader('Presenter panel: Switch properties'),
          CheckboxListTile(
            title: const Text('activeTrackColor'),
            subtitle: const Text('Default: theme primary  →  Custom: amber'),
            value: _useCustomActiveTrackColor,
            onChanged: (value) =>
                setState(() => _useCustomActiveTrackColor = value!),
          ),
          CheckboxListTile(
            title: const Text('inactiveThumbColor'),
            subtitle: const Text('Default: theme outline  →  Custom: orange'),
            value: _useCustomInactiveThumbColor,
            onChanged: (value) =>
                setState(() => _useCustomInactiveThumbColor = value!),
          ),
          CheckboxListTile(
            title: const Text('thumbIcon'),
            subtitle: const Text('Default: no icon  →  Custom: sun / moon'),
            value: _useThumbIcon,
            onChanged: (value) => setState(() => _useThumbIcon = value!),
          ),
        ],
      ),
    );
  }
}

/// Small grey heading above each group of settings.
class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
