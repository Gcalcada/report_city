import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OnboardingScreen()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/1.png', // Adjusted asset path
                height: 100,
              ),
              SizedBox(height: 20),
              Text(
                'Report City',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Make your authentic report',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  final List<Map<String, String>> _slides = [
    {
      'image': 'assets/1.png',
      'title': 'Welcome to Report City!',
      'description': 'Make your authentic reports with ease.',
    },
    {
      'image': 'assets/2.png',
      'title': 'Discover New Places',
      'description': 'Explore new areas and find interesting places near you.',
    },
    {
      'image': 'assets/3.png',
      'title': 'Join the Community',
      'description': 'Connect with others and share your experiences.',
    },
  ];

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  Widget _buildPage(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            _slides[index]['image']!,
            height: 200,
          ),
          SizedBox(height: 48),
          Text(
            _slides[index]['title']!,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          Text(
            _slides[index]['description']!,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        itemCount: _slides.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: _buildPage(context, index)),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (index == _slides.length - 1) {
                    _navigateToHome(context);
                  } else {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                },
                child:
                    Text(index == _slides.length - 1 ? 'Get Started' : 'Next'),
              ),
              SizedBox(height: 48),
            ],
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome to the Home Screen'),
      ),
    );
  }
}
