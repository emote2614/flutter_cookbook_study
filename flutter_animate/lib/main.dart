import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

void main() {
  runApp(MaterialApp(home: PhysicsDrag()));
}

class PhysicsDrag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DragCard(
          child: FlutterLogo(
        size: 128,
      )),
    );
  }
}

class DragCard extends StatefulWidget {
  final Widget child;

  const DragCard({super.key, required this.child});

  @override
  _DragCardState createState() => _DragCardState();
}

class _DragCardState extends State<DragCard> with SingleTickerProviderStateMixin {
  // 애니메이션 컨트롤러 선언
  late AnimationController _controller;
  Alignment _dragAlignment = Alignment.center;
  late Animation<Alignment> _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // 애니메이션이 적용된 페이지를 벗어나도 백그라운드에서는 해당 애니메이션이 계속 움직이고 있기때문에 애니메이션을 제거
    _controller.dispose();
    super.dispose();
  }

  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(AlignmentTween(
      begin: _dragAlignment,
      end: Alignment.center,
    ));
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );
    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Align(
        child: GestureDetector(
      onPanDown: (details) {
        _controller.stop();
      },
      onPanUpdate: (details) {
        setState(() {
          _dragAlignment +=
              Alignment(details.delta.dx / (size.width / 2), details.delta.dy / (size.height / 2));
        });
      },
      onPanEnd: (details) {
        _runAnimation(details.velocity.pixelsPerSecond, size);
      },
      child: Align(
        alignment: _dragAlignment,
        child: Card(
          child: widget.child,
        ),
      ),
    ));
  }
}
