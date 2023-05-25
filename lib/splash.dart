import 'package:anim/ambu_splash.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _animationControllerSlide;
  Animation<double>? _animation;
  late Animation<Offset> _animationSlide;
  bool toGo = false;
  bool close = false;
  @override
  void initState() {
    super.initState();
    _animationControllerSlide =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animationSlide = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -0.9)).animate(
        _animationControllerSlide);

    _animationControllerSlide.forward().whenComplete(() {
      // put here the stuff you wanna do when animation completed!
      _startOrStop();
    });
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween(begin: 0.0, end: 12.55).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
  }

  _startOrStop() {
    print(
        'start/stop ${_animationController.status} - ${_animationController.isAnimating}');
    if (_animationController.isAnimating) {
      _animationController.stop();
    } else {
      _animationController.reset();
      _animationController.forward().whenComplete((){
        setState(() {
          toGo = true;
        });
        _animationControllerSlide.reverse().whenComplete((){
          setState(() {
            close = true;
          });
        });
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width-50,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const AmbuSplash()));
                  },
                  child:  const Text('Next', style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children:  [
                 if(!close)
                 const Text("F", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
                 if(!close)
                 const Text("L", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
                 SlideTransition(
                     position: _animationSlide,
                     child: AnimatedBuilder(
                         animation: _animation!,
                         child: !toGo?const Text("U", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),):Image.asset("assets/logobird.png", height: !close?70:300),
                         builder: (context, child) {
                           return Transform.rotate(
                             angle: _animation!.value,
                             child: child,
                           );
                         }),
                 ),
                 if(!close)
                 const Text("T", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
                 if(!close)
                 const Text("T", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
                 if(!close)
                 const Text("E", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
                 if(!close)
                 const Text("R", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
               ],
             )
          ],
        ),
      ),
    );
  }
}