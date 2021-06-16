import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: 10.0,
      decoration: BoxDecoration(
        color: isActive ? kprimarycolor : textgrey,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          color: _currentPage == 0 ? kprimarycolor : textwhite,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _currentPage == _numPages - 1
                    ? Container()
                    : Container(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (route) => false),
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: textwhite,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                Container(
                  height: 600.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Container(
                        color: kprimarycolor,
                        height: size.height,
                        child: Center(
                          child: Text(
                            'Groso',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: textwhite),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/ob1.png',
                                  ),
                                  height: 300.0,
                                  width: 300.0,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                'E Shopping',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: textblack),
                              ),
                              SizedBox(height: 15.0),
                              Text('Explore top quality products',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(color: textgrey)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/ob2.png',
                                  ),
                                  height: 300.0,
                                  width: 300.0,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                'Delivery on the way',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: textblack),
                              ),
                              SizedBox(height: 15.0),
                              Text('Get your order by speed delivery',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(color: textgrey)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/ob3.png',
                                  ),
                                  height: 300.0,
                                  width: 300.0,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                'Delivery Arrived',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: textblack),
                              ),
                              SizedBox(height: 15.0),
                              Text('Order is arrived at your place',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(color: textgrey)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _currentPage == 0
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator(),
                      ),
                SizedBox(
                  height: 30,
                ),
                _currentPage == 0
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: RaisedButton(
                            color: textwhite,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Next',
                                    style: TextStyle(
                                      color: kprimarycolor,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: kprimarycolor,
                                    size: 30.0,
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      )
                    : _currentPage != _numPages - 1
                        ? Expanded(
                            child: Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: RaisedButton(
                                color: kprimarycolor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'Next',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  _pageController.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          )
                        : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 50.0,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: kprimarycolor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
