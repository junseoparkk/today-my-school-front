import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:today_my_school/models/model_auth.dart';
import 'package:today_my_school/models/model_login.dart';
import 'package:today_my_school/style.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginFieldModel(),
      builder: (context, child) {
        return Scaffold(
          appBar: null,
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 56.h),
                  const LoginTitle(),
                  SizedBox(height: 40.h),
                  const EmailInput(),
                  SizedBox(height: 8.h),
                  const PasswordInput(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      GoPasswordResetButton(),
                      GoSignupButton(),
                    ],
                  ),
                  const Spacer(),
                  const LoginButton(),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
          bottomSheet: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
          ),
        );
      },
    );
  }
}

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '한국해양대학교 시설물 예약 시스템',
          style: TextStyleSet.light15.copyWith(color: ColorPalette.blue),
        ),
        SizedBox(height: 8.h),
        Text(
          'Login',
          style: TextStyleSet.extrabold30.copyWith(color: ColorPalette.blue),
        ),
      ],
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final loginField = Provider.of<LoginFieldModel>(context, listen: false);
    return SizedBox(
      width: 248.w,
      height: 48.h,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (email) {
          loginField.setEmail(email);
        },
        style: TextStyleSet.regular15,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: 'ID(학교 웹메일)',
          hintStyle: TextStyleSet.regular13.copyWith(color: ColorPalette.grey),
          errorStyle: TextStyleSet.regular13.copyWith(color: ColorPalette.red),
          isDense: true,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: ColorPalette.grey,
              width: 1,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: ColorPalette.blue,
              width: 2,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: ColorPalette.red,
              width: 1,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: ColorPalette.red,
              width: 2,
            ),
          ),
        ),
        cursorColor: ColorPalette.black,
        autofocus: true,
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final loginField = Provider.of<LoginFieldModel>(context, listen: false);
    return SizedBox(
      width: 248.w,
      height: 48.h,
      child: TextField(
        onChanged: (password) {
          loginField.setPassword(password);
        },
        style: TextStyleSet.regular15,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'PASSWORD',
          hintStyle: TextStyleSet.regular13.copyWith(color: ColorPalette.grey),
          errorStyle: TextStyleSet.regular13.copyWith(color: ColorPalette.red),
          isDense: true,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: ColorPalette.grey,
              width: 1,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: ColorPalette.blue,
              width: 2,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: ColorPalette.red,
              width: 1,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: ColorPalette.red,
              width: 2,
            ),
          ),
        ),
        cursorColor: ColorPalette.black,
      ),
    );
  }
}

class GoPasswordResetButton extends StatelessWidget {
  const GoPasswordResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/password_reset');
      },
      child: Text(
        '비밀번호 재설정',
        style: TextStyleSet.medium13.copyWith(color: ColorPalette.grey),
      ),
    );
  }
}

class GoSignupButton extends StatelessWidget {
  const GoSignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/signup');
      },
      child: Text(
        '회원가입',
        style: TextStyleSet.medium13.copyWith(color: ColorPalette.grey),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthModel>(context, listen: false);
    final loginField = Provider.of<LoginFieldModel>(context, listen: false);
    return SizedBox(
      width: 128,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorPalette.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () async {
          await auth.loginWithEmail(loginField.email, loginField.password).then(
            (loginStatus) {
              if (loginStatus == AuthStatus.loginSuccess) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('로그인 성공! 반가워요')),
                  );
                Navigator.pushReplacementNamed(context, '/home');
              } else {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('로그인에 실패했어요 다시 시도해주세요')),
                  );
              }
            },
          );
        },
        child: Text(
          '로그인',
          style: TextStyleSet.bold16.copyWith(color: ColorPalette.white),
        ),
      ),
    );
  }
}
