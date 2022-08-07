import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/firebase_options.dart';
import 'package:notesapp/loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MaterialApp(
    home: LoadingPage(),
  ));
}

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
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: const Color(0xffff5858),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: CustomPaint(
                painter: BlueCurve(),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: const EdgeInsets.only(bottom: 20,left: 10),child: Image.asset('assets/mobicon.png',)),

                  const Padding(padding: EdgeInsets.all(10),child: Text('Welcome to Notes',style: TextStyle(color: Colors.white,fontSize: 18),))
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