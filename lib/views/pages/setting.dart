
import 'package:flutter/material.dart';
import 'package:lesson_43/views/pages/password.dart';
import '../../utils/app_constant.dart';
import '../widgets/custom_drawer.dart';

class SettingsScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onImageChanged;
  final ValueChanged<List> changePassword;

  const SettingsScreen({
    super.key,
    required this.onThemeChanged,
    required this.onImageChanged,
    required this.changePassword,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _controller = TextEditingController();
  double _currentSlider = 14;
  String parol = '';
  Color pickerColor = Colors.blue; // Initial color for the ColorPicker

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onColorChanged(Color color) {
    setState(() {
      pickerColor = color;
    });
    // Handle the color change if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sozlamalar"),
        actions: [
          IconButton(
            onPressed: () {
              String imageUrl = _controller.text;
              _controller.clear();
              widget.onImageChanged(imageUrl);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      drawer: CustomDrawer(
        onThemeChanged: widget.onThemeChanged,
        onImageChanged: widget.onImageChanged,
        changePassword: widget.changePassword,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              AppConstants.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Text(' '));
              },
            ),
          ),
          ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Rasm qo'yish",
                ),
                controller: _controller,
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                activeColor: Colors.green,
                value: AppConstants.themeMode == ThemeMode.dark,
                onChanged: (bool value) {
                  setState(() {
                    AppConstants.themeMode =
                    value ? ThemeMode.dark : ThemeMode.light;
                  });
                  widget.onThemeChanged(value);
                },
                title: Text(
                  AppConstants.themeMode == ThemeMode.dark
                      ? "Tungi holat"
                      : "Kunduzgi holat",
                  style: TextStyle(fontSize: _currentSlider),
                ),
              ),
              SwitchListTile(
                activeColor: Colors.green,
                value: Password.checkKey,
                onChanged: (value) {
                  setState(() {
                    Password.checkKey = value;
                  });
                  widget.changePassword([value, null]);
                },
                title: Text(
                  "Parol Yoqish",
                  style: TextStyle(fontSize: _currentSlider),
                ),
              ),
              if (Password.checkKey)
                Column(
                  children: [
                    TextField(
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(fontSize: 20),
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      onChanged: (value) {
                        parol = value;
                      },
                      decoration: const InputDecoration(
                        labelText: "New password",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 20),
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      onSubmitted: (value) {
                        if (value == parol) {
                          setState(() {
                            Password.key = value;
                          });
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => PasswordScreen(),
                            ),
                          );
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: "Repeat new password",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              Slider(
                min: 14,
                max: 40,
                divisions: 26,
                value: _currentSlider,
                onChanged: (value) {
                  setState(() {
                    _currentSlider = value;
                  });
                  widget.changePassword([null, _currentSlider]);
                },
                label: _currentSlider.round().toString(),
                activeColor: Colors.blue,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Example: Cillum eiusmod mollit est quis.",
                  style: TextStyle(fontSize: _currentSlider),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
