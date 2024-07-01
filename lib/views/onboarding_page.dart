import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sipegpdam/views/login_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool _dontShowAgain = false;

  final storage = FlutterSecureStorage();

  final List<Map<String, String>> _pages = [
    {
      'title': 'Welcome',
      'description': 'Welcome to our app!',
      'image': 'lib/images/welcome.png',
    },
    {
      'title': 'Features',
      'description': 'Explore amazing features!',
      'image': 'lib/images/fitur.png',
    },
    {
      'title': 'Get Started',
      'description': 'Get started now!',
      'image': 'lib/images/started.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _checkDontShowAgain();
  }

  Future<void> _checkDontShowAgain() async {
    final value = await storage.read(key: 'dont_show_onboarding');
    setState(() {
      _dontShowAgain = value == 'true';
    });
  }

  Future<void> _setDontShowAgain(bool value) async {
    await storage.write(key: 'dont_show_onboarding', value: value.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _pages[index]['title']!,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _pages[index]['description']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        Image(image: AssetImage(_pages[index]['image']!))
                      ],
                    ),
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
            const SizedBox(height: 20),
            if (_currentPage == _pages.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Checkbox(
                      value: _dontShowAgain,
                      onChanged: (bool? value) {
                        setState(() {
                          _dontShowAgain = value ?? false;
                        });
                        _setDontShowAgain(_dontShowAgain);
                      },
                    ),
                    const Text('Don\'t show again'),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.lightBlueAccent,
                foregroundColor: Colors.black,
                elevation: 5,
                minimumSize: const Size(300, 50),
              ),
              onPressed: () {
                if (_currentPage < _pages.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                } else {
                  if (_dontShowAgain) {
                    _setDontShowAgain(true);
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }
              },
              child: Text(
                _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _pages.length; i++) {
      indicators.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return indicators;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.lightBlueAccent : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
