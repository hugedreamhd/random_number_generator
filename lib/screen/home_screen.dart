import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_number_generator/constant/color.dart';
import 'package:random_number_generator/screen/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int maxNumber = 1000;
  List<int> randomNumbers = [
    123,
    456,
    789,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                onPressed: onSettingsPop,
              ),
              _Body(
                randomNumbers:
                    randomNumbers, //randomNumbers 파라미터에 randomNumbers 변수를 넣는다
              ),
              _Footer(
                onPressed: onRandomNumberGenerate,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSettingsPop() async {
    final int? result = await Navigator.of(context).push<int>(
      //int를 돌려준다고 했지만, int? 값을 돌려줘야한다 왜? 슬라이드 움직이다가 뒤로 페이지를 가버릴수가 있으니까 null이 들어올수가 있다
      //미래에 돌려받을 값 = await / async
      //<int> 제너릭 int라고 하면 result가 int값을 받는다고 인식
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SettingScreen();
        },
      ),
    );

    if (result != null) {
      setState(() {
        maxNumber = result;
      });
    }
  }

  void onRandomNumberGenerate() {
    final rand = Random(); //숫자와 관련된 기본 함수

//                        final List<int> newNumbers =
    //                          []; //실행 함수가 실행되서 리스트에 추가되는 값
    final Set<int> newNumbers = {};
    // for (int i = 0; i < 3; i++) {
    //   //조건문
    //   final number = rand.nextInt(1000);

    //   newNumbers.add(number); //실행 함수
    // } set함수로 바꿔서 중복을 방지하려 했으나 if 문을 쓰게 되면
    // 중복값이 set에 값이 안들어갈 뿐이지 실제로 로직은 실행되서
    // 2개의 값만 들어가는 경우가 발생
    while (newNumbers.length != 3) {
      //그래서 실제로 3개의 숫자가 newNumbers에 들어
      final number = rand.nextInt(maxNumber);

      newNumbers.add(number);
    }

    setState(() {
      randomNumbers =
          newNumbers.toList(); // newNumbers를 randonNumbers로 교체한다(setState)
    });
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;

  const _Header({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '랜덤 숫자 생성기',
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w700),
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.settings,
            color: redcolor,
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> randomNumbers;

  const _Body({required this.randomNumbers, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomNumbers //변수 호출
            .asMap()
            .entries //asmap이 뒤에 나오는 x 값의 key(인덱스)와 value(실제값) 값을 지정 할 수 있다
            .map(
              (x) => Padding(
                padding: EdgeInsets.only(
                    bottom: x.key == 2
                        ? 0
                        : 16.0), //if문이 아니어도 이렇게 삼항연산자 사용이 가능 / 여기서는 인덱스를 활용
                child: Row(
                  children: //왜 칠드런인데 [] 괄호를 안쓰지?
                      x.value
                          .toString()
                          .split('')
                          .map(
                            (y) => Image.asset(
                              'asset/img/$y.png',
                              height: 70.0,
                              width: 50.0,
                            ),
                          )
                          .toList(),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footer({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: redcolor,
              foregroundColor: Colors.white,
            ),
            onPressed: onPressed,
            child: Text('생성하기'),
          ),
        ),
      ],
    );
  }
}
