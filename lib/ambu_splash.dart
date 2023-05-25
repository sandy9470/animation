import 'package:flutter/material.dart';

class AmbuSplash extends StatefulWidget {
  const AmbuSplash({Key? key}) : super(key: key);

  @override
  State<AmbuSplash> createState() => _AmbuSplashState();
}

class _AmbuSplashState extends State<AmbuSplash> with TickerProviderStateMixin {
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
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _animationSlide = Tween<Offset>(begin: const Offset(0, 0),
        end: const Offset(1.5, 0)).animate(
        _animationControllerSlide);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _animation = Tween(begin: 0.0, end: 50.55).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
  }

  @override
  void dispose(){
    _animationControllerSlide.dispose();
    _animationController.dispose();
    super.dispose();
  }
  ambuMove(){
    _animationControllerSlide.forward().whenComplete(() {
      // put here the stuff you wanna do when animation completed!
    });
  }
  _startOrStop() {
    print(
        'start/stop ${_animationController.status} - ${_animationController.isAnimating}');
    if (_animationController.isAnimating) {
      _animationController.stop();
    } else {
      _animationController.reset();
      _animationController.forward().whenComplete((){

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
                    ambuMove();
                    _startOrStop();
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
          children: [
            SizedBox(
              height: 500,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                 Positioned(
                     left: -250,
                     right: 10,
                     top: 10,
                     bottom: 10,
                     child: SlideTransition(
                       position: _animationSlide,
                       child: Stack(
                         children: [
                           Image.asset("assets/Ambulance_Car_Flat_Icon_Vector.png"),
                           Positioned(
                               bottom: 133,
                               left: 102,
                               child: AnimatedBuilder(
                                   animation: _animation!,
                                   child:  const CircleAvatar(
                                     radius: 25,
                                     backgroundColor: Colors.white,
                                     child: CircleAvatar(
                                       radius: 20,
                                       backgroundColor: Colors.black,
                                       child: Text("|", style: TextStyle(color: Colors.white),),
                                     ),
                                   ),
                                   builder: (context, child) {
                                     return Transform.rotate(
                                       angle: _animation!.value,
                                       child: child,
                                     );
                                   })),
                           Positioned(
                                bottom: 133,
                               left: 322,
                               child: AnimatedBuilder(
                                   animation: _animation!,
                                   child:  const CircleAvatar(
                                     radius: 25,
                                     backgroundColor: Colors.white,
                                     child: CircleAvatar(
                                       radius: 20,
                                       backgroundColor: Colors.black,
                                       child: Text("|", style: TextStyle(color: Colors.white),),
                                     ),
                                   ),
                                   builder: (context, child) {
                                     return Transform.rotate(
                                       angle: _animation!.value,
                                       child: child,
                                     );
                                   }))
                         ],
                       ))
                     ),
                  /*Positioned(
                      bottom: 145,
                      child:  Container(
                        height: 2,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black.withOpacity(0.3),
                      )
                  ),*/

                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}
