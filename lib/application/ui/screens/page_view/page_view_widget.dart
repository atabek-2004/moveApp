import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:move/application/ui/navigations/main_navigation.dart';
import 'package:move/application/ui/themes/app_theme.dart';
import 'package:move/resources/resources.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageViewWidget extends StatefulWidget {
  const PageViewWidget({super.key});

  @override
  PageViewWidgetState createState() => PageViewWidgetState();
}

class PageViewWidgetState extends State<PageViewWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.decelerate,
      );
    } else {
      Navigator.of(context)
          .pushReplacementNamed(MainNavigationRouteNames.mainMenu);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: [
                OnboardingPage(
                  image:
                      const Image(image: AssetImage(Images.onBoardGirlSitting)),
                  title: 'Храните информацию о вещах в своём телефоне',
                  buttonText: 'Продолжить',
                  onPressed: _nextPage,
                  currentPage: _currentPage,
                ),
                OnboardingPage(
                  image:
                      const Image(image: AssetImage(Images.onBoardManSitting)),
                  title: 'Помечайте и сортируйте собранные коробки',
                  buttonText: 'Продолжить',
                  onPressed: _nextPage,
                  currentPage: _currentPage,
                ),
                OnboardingPage(
                  image:
                      const Image(image: AssetImage(Images.onboardNotSiting)),
                  title:
                      'Отмечайте уже доставленные вещи и следите за отгрузками',
                  buttonText: 'Готово',
                  onPressed: _nextPage,
                  currentPage: _currentPage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onPressed;
  final int currentPage;
  final Widget image;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onPressed,
    required this.currentPage,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              width: 350.w,
              height: 350.h,
              child: image,
            ),
            SizedBox(height: 15.h),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                height: (24 / 20).h,
                letterSpacing: -0.40799999237060547,
                decoration: TextDecoration.none,
                decorationStyle: TextDecorationStyle.solid,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            DotsIndicator(
              dotsCount: 3,
              position: currentPage,
              decorator: DotsDecorator(
                activeColor: Colors.black,
                color: Colors.grey,
                size: Size.square(9.0.w),
                activeSize: Size.square(9.0.w),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                spacing: EdgeInsets.symmetric(horizontal: 4.0.w),
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: 310.w,
              height: 44.h,
              child: ElevatedButton(
                style: ButtonStyle(
                  textStyle: WidgetStatePropertyAll(
                    TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.40799999237060547,
                      fontFamily: 'Open Sans',
                    ),
                  ),
                  shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  backgroundColor:
                      const WidgetStatePropertyAll(AppTheme.appColor),
                  foregroundColor:
                      const WidgetStatePropertyAll(AppTheme.foreGroundColor),
                ),
                onPressed: onPressed,
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
