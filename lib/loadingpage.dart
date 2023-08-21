import 'package:flutter/material.dart';
import 'package:notesapp/utils/wrapper.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const Wrapper())),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // final screensize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Stack(
          children: [
            Container(
              color: const Color(0xffff5858),
            ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    // height: screensize.height * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 20),
                      child: Image.asset(
                        'assets/mobicon.png',
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      LayoutBuilder(builder: (context, box) {
                        return SizedBox(
                          height: box.maxHeight,
                          width: box.maxWidth,
                          child: CustomPaint(
                            painter: BlueCurve(),
                          ),
                        );
                      }),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Welcome to Notes',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            // Text("data"),
          ],
        ),
      ),
    );
  }
}

class BlueCurve extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xff01bff9)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.1);
    path.arcToPoint(Offset(size.width, size.height * 0.1), radius: const Radius.circular(600));
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
