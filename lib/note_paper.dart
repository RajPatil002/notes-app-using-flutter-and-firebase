import 'package:flutter/material.dart';

class NotePaper extends StatefulWidget {
  final String title, message;

  const NotePaper({super.key, required this.title, required this.message});

  @override
  State<NotePaper> createState() => _NotePaperState();
}

class _NotePaperState extends State<NotePaper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ScrollController _scrollController = ScrollController();
  double _scrolled = 0;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _controller.forward();
    _scrollController.addListener(() {
      setState(() {
        _scrolled = _scrollController.position.pixels;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        top: 20,
        right: 20,
      ),
      child: LayoutBuilder(builder: (context, box) {
        // print(box);
        return CustomPaint(
          willChange: true,
          painter: NotePage(scrolled: _scrolled + (box.maxWidth * 0.15)),
          // margin: const EdgeInsets.all(20),
          // decoration: const BoxDecoration(
          //   // borderRadius: BorderRadius.circular(20),
          //   color: Color(0xff01bff9),
          // ),
          child: Padding(
            padding: EdgeInsets.only(left: box.maxWidth * 0.15, top: 3, right: 3),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 10,
                top: 10,
                right: 10,
              ),
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        width: 3,
                        color: Colors.grey,
                        style: BorderStyle.solid,
                      ),
                    )),
                    child: Text(
                      widget.title,
                      style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizeTransition(
                    sizeFactor: CurvedAnimation(parent: _controller, curve: Curves.linearToEaseOut),
                    child: Text(
                      widget.message,
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class NotePage extends CustomPainter {
  final double scrolled;
  NotePage({required this.scrolled});
  @override
  void paint(Canvas canvas, Size size) {
    // print(size);
    Paint rolled = Paint()..color = Colors.grey;
    Paint rolledBorder = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    Path path2 = Path();
    path2.moveTo(0, size.width * 0.05);
    path2.lineTo(0, scrolled);
    path2.lineTo(size.width * 0.1, scrolled);
    path2.lineTo(size.width * 0.1, size.width * 0.05);
    path2.quadraticBezierTo(size.width * 0.1, 0, size.width * 0.05, 0);
    path2.quadraticBezierTo(0, 0, 0, size.width * 0.05);

    canvas.drawPath(path2, rolled);
    canvas.drawPath(path2, rolledBorder);

    // print(controller.position.pixels);
    Path path = Path();
    path.moveTo(size.width * 0.05, 0);
    path.lineTo(size.width * 0.95, 0);
    path.quadraticBezierTo(size.width, 0, size.width, size.width * 0.05);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width * 0.1, size.height);
    path.lineTo(size.width * 0.1, size.width * 0.05);
    path.quadraticBezierTo(size.width * 0.1, 0, size.width * 0.05, 0);

    canvas.drawPath(path, Paint()..color = Colors.white);
    canvas.drawPath(
        path,
        Paint()
          ..color = Colors.black
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke);
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
