import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:today_my_school/models/model_auth.dart';
import 'package:today_my_school/models/model_editor.dart';
import 'package:today_my_school/style.dart';
import 'package:provider/provider.dart';

class ProfileEditorPage extends StatefulWidget {
  const ProfileEditorPage({super.key});

  @override
  State<ProfileEditorPage> createState() => _ProfileEditorPageState();
}

class _ProfileEditorPageState extends State<ProfileEditorPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey();
  static String email = '';
  static String name = '';
  static String phone = '';

  Future _getUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (snapshot) {
        if (snapshot.exists) {
          setState(() {
            email = snapshot.data()!['email'];
            name = snapshot.data()!['name'];
            phone = snapshot.data()!['phone'];
            snapshot.data()!['uid'];
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUser();
    });
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthModel>(context, listen: false);
    return ChangeNotifierProvider(
      create: (_) => EditorFieldModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.white,
          foregroundColor: ColorPalette.blue,
          title: const Text('내 정보 수정'),
          actions: [
            IconButton(
              onPressed: () async {
                await auth.logout();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('로그아웃 완료!')),
                  );
                Navigator.of(context).pushReplacementNamed('/login');
              },
              icon: const Icon(
                Icons.logout_rounded,
                size: 24,
              ),
            ),
          ],
        ),
        body: Builder(
          builder: (BuildContext context){
            if(email.isNotEmpty){
              return SafeArea(
                child: Center(
                  child: GestureDetector(
                    onTap: (){
                      FocusScope.of(context).unfocus();
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                    EdgeInsets.symmetric(horizontal: 24.w),
                                  child: Center(
                                    child:Form(
                                      key:_formKey,
                                      child:Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 8.h),
                                              const InputGuide(),
                                              const Divider(),
                                              const EmailInput(),
                                              const PasswordInput(),
                                              const PasswordConfirmInput(),
                                              const NameInput(),
                                              const PhoneInput(),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(0,16.h,0,40.h),
                                            child: const EditButton(),
                                          )
                                        ],
                                      )
                                    )
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              );
            }else{
              return Center(child:CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class InputGuide extends StatelessWidget {
  const InputGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '* ',
        style: TextStyleSet.semibold15.copyWith(color: ColorPalette.red),
        children: <TextSpan>[
          TextSpan(text: '수정할 정보를 입력해주세요', style: TextStyleSet.medium15),
        ],
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final editorField = Provider.of<EditorFieldModel>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 22.h),
          child: Text(
            '아이디(학교 웹메일)',
            style: TextStyleSet.light13,
          ),
        ),
        SizedBox(
          width: 192.w,
          height: 64.h,
          child: TextFormField(
            initialValue: _ProfileEditorPageState.email,
            keyboardType: TextInputType.emailAddress,
            onChanged: (email) {
              editorField.setEmail(email);
            },
            onSaved: (email) {
              editorField.setEmail(email!);
            },
            validator: (email) {
              if (email!.trim().isEmpty || !email.contains('kmou.ac.kr')) {
                return '학교 웹메일을 입력하세요';
              }
              return null;
            },
            style: TextStyleSet.regular15,
            decoration: InputDecoration(
              helperText: '',
              errorStyle:
                  TextStyleSet.light11.copyWith(color: ColorPalette.red),
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
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
        ),
      ],
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 22.h),
          child: Text(
            '비밀번호(6자리 이상)',
            style: TextStyleSet.light13,
          ),
        ),
        SizedBox(
          width: 192.w,
          height: 64.h,
          child: TextFormField(
            style: TextStyleSet.regular15,
            obscureText: true,
            decoration: InputDecoration(
              helperText: '',
              errorStyle:
                  TextStyleSet.light11.copyWith(color: ColorPalette.red),
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              filled: true,
              fillColor: ColorPalette.lightGrey.withOpacity(0.2),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.grey,
                  width: 1,
                ),
              ),
            ),
            enabled: false,
            cursorColor: ColorPalette.black,
          ),
        )
      ],
    );
  }
}

class PasswordConfirmInput extends StatelessWidget {
  const PasswordConfirmInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 22.h),
          child: Text(
            '비밀번호 확인',
            style: TextStyleSet.light13,
          ),
        ),
        SizedBox(
          width: 192.w,
          height: 64.h,
          child: TextFormField(
            style: TextStyleSet.regular15,
            obscureText: true,
            decoration: InputDecoration(
              helperText: '',
              errorStyle:
                  TextStyleSet.light11.copyWith(color: ColorPalette.red),
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              filled: true,
              fillColor: ColorPalette.lightGrey.withOpacity(0.2),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: ColorPalette.grey,
                  width: 1,
                ),
              ),
            ),
            enabled: false,
            cursorColor: ColorPalette.black,
          ),
        )
      ],
    );
  }
}

class NameInput extends StatelessWidget {
  const NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    final editorField = Provider.of<EditorFieldModel>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 22.h),
          child: Text(
            '이름',
            style: TextStyleSet.light13,
          ),
        ),
        SizedBox(
          width: 192.w,
          height: 64.h,
          child: TextFormField(
            initialValue: _ProfileEditorPageState.name,
            onChanged: (name) {
              editorField.setName(name);
            },
            onSaved: (name) {
              editorField.setName(name!);
            },
            validator: (name) {
              if (name!.trim().isEmpty) {
                return '이름을 입력하세요';
              }
              return null;
            },
            style: TextStyleSet.regular15,
            decoration: InputDecoration(
              helperText: '',
              errorStyle:
                  TextStyleSet.light11.copyWith(color: ColorPalette.red),
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
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
        )
      ],
    );
  }
}

class PhoneInput extends StatelessWidget {
  const PhoneInput({super.key});

  @override
  Widget build(BuildContext context) {
    final editorField = Provider.of<EditorFieldModel>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 22.h),
          child: Text(
            '연락처',
            style: TextStyleSet.light13,
          ),
        ),
        SizedBox(
          width: 192.w,
          height: 64.h,
          child: TextFormField(
            initialValue: _ProfileEditorPageState.phone,
            keyboardType: TextInputType.phone,
            onChanged: (phone) {
              editorField.setPhone(phone);
            },
            onSaved: (phone) {
              editorField.setPhone(phone!);
            },
            validator: (phone) {
              if (phone!.trim().isEmpty || phone.length < 10) {
                return '전화번호를 입력하세요';
              }
              return null;
            },
            style: TextStyleSet.regular15,
            decoration: InputDecoration(
              helperText: '',
              errorStyle:
                  TextStyleSet.light11.copyWith(color: ColorPalette.red),
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
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
        )
      ],
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthModel>(context, listen: false);
    final editorField = Provider.of<EditorFieldModel>(context, listen: false);
    return SizedBox(
      width: 128.w,
      height: 40.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorPalette.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () async {
          if (_ProfileEditorPageState._formKey.currentState!.validate()) {
            _ProfileEditorPageState._formKey.currentState!.save();
            await auth.updateUser(editorField).then(
              (updateStatus) {
                if (updateStatus == AuthStatus.updateSuccess) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(content: Text('수정 완료!')),
                    );
                } else {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(content: Text('수정에 실패했어요 다시 시도해주세요')),
                    );
                }
              },
            );
          }
        },
        child: Text(
          '저장하기',
          style: TextStyleSet.bold16.copyWith(color: ColorPalette.white),
        ),
      ),
    );
  }
}
