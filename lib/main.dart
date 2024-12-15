import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AnimationComponent(
                    child: FilledButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.orange),
                          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16))),
                      onPressed: () {},
                      child: Text(
                        "Button",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimationComponent extends StatefulWidget {
  const AnimationComponent({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<AnimationComponent> createState() => _AnimationComponentState();
}

class _AnimationComponentState extends State<AnimationComponent> {
  bool animate = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CupertinoSwitch(
          value: animate,
          onChanged: (value) {
            setState(() {
              animate = value;
            });
          },
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: RepaintBoundary(
                child: widget.child
                    .animate(
                      key: UniqueKey(),
                      autoPlay: animate,
                      onComplete: (controller) async {
                        await Future.delayed(Duration(milliseconds: 1300));
                        controller.forward(from: 0);
                      },
                    )
                    .shimmer(
                      delay: const Duration(milliseconds: 1300),
                      color: Colors.white,
                      duration: const Duration(seconds: 2),
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
