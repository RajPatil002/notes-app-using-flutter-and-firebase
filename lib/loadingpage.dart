import 'package:flutter/material.dart';
import 'package:notesapp/homepage.dart';
import 'package:notesapp/loginpage.dart';


class LoadingPage extends StatefulWidget {
  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // http.Request('Hi',Uri.parse('https://www.googleapis.com/auth/cloud-firestore'));
      // final resp = await http.patch(Uri.parse('https://firestore.googleapis.com/v1/projects/notesappbyraj/databases/Notes'),body: jsonEncode({"name": "aaaaaaaaaaaaaaaaaaa"}));
      // Map m = jsonDecode(resp.body);
      // print(m);
      await Future.delayed(const Duration(seconds: 3));
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage(uid: "3bAm8UUxT2fFbCwKSnJ7QuPKN013")));
    });
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: const Color(0xffff5858),
            ),
            SizedBox(
              height: screensize.height * 0.5,
              width: screensize.width,
              child: CustomPaint(
                painter: BlueCurve(),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screensize.height/2,child: Image.asset('assets/mobicon.png',alignment: Alignment.bottomCenter,)),

                  Container(height: screensize.height/2,alignment: Alignment.topCenter,child: const Text('Welcome to Notes',style: TextStyle(color: Colors.white,fontSize: 18),),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class BlueCurve extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
      ..color = const Color(0xff01bff9)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.2);
    // path.quadraticBezierTo(size.width/2, 0, size.width, size.height * 0.2);
    path.arcToPoint(Offset(size.width, size.height * 0.2),radius: const Radius.circular(500));
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);

    // path.moveTo(x, y);
    // canvas.drawCircle(Offset(size.height/2, size.width/2), 400, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

}