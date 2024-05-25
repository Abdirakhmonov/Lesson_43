
import 'package:flutter/material.dart';
import '../../utils/app_constant.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onImageChanged;
  final ValueChanged<List> changePassword;

  const HomeScreen(
      {super.key,
        required this.onThemeChanged,
        required this.onImageChanged,
        required this.changePassword});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bosh Sahifa"),
      ),
      drawer: CustomDrawer(
          onThemeChanged: widget.onThemeChanged,
          onImageChanged: widget.onImageChanged,
          changePassword: widget.changePassword),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.network(
              AppConstants.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Text(' '));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                style: TextStyle(
                  fontSize: TextSize.size,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
