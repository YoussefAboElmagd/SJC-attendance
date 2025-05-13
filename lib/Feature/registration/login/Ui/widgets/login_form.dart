import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/registration/login/Logic/cubit/login_cubit.dart';
import 'package:madarj/Feature/registration/login/data/model/login_request_body.dart';
import 'package:madarj/Feature/registration/login/Ui/widgets/login_bloc_listener.dart';
import 'package:madarj/generated/l10n.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.rememberMe,
    required this.obscurePassword,
    required this.onRememberMeChanged,
    required this.onTogglePassword,
  });

  final bool rememberMe;
  final bool obscurePassword;
  final Function(bool) onRememberMeChanged;
  final VoidCallback onTogglePassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 35.0.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.w),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0.w, horizontal: 24.0.h),
          child: SingleChildScrollView(
            child: Form(
              key: context.read<LoginCubit>().formKey,
              child: Column(
                children: [
                  Text(S.of(context).sign_text,
                      style: TextStyles.font32BlackBold),
                  SizedBox(height: 6.h),
                  Text(S.of(context).sign_sub_text),
                  SizedBox(height: 30.h),
                  _buildEmailField(context),
                  SizedBox(height: 20.h),
                  _buildPasswordField(context),
                  _buildRememberMeRow(context),
                  SizedBox(height: 20.h),
                  _buildSignInButton(context),
                  SizedBox(height: 20.h),
                  Container(
                    // width: MediaQuery.sizeOf(context).width * .29,
                    decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.circular(
                        //   25,
                        // ),
                        // border: Border.all(
                        //   color: const Color.fromRGBO(42, 49, 131, 1),
                        // ),
                        ),
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(Routes.language);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.0.h,
                          horizontal: 8.0.w,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              S.of(context).change_language_button,
                              style: TextStyles.font16BlackSemiBold,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            CircleAvatar(
                              radius: 20.w,
                              backgroundColor: Colors.white,
                              child: SvgPicture.asset(
                                "assets/svgs/language.svg",
                                colorFilter: const ColorFilter.mode(
                                  Colors.blue,
                                  BlendMode.srcIn,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const LoginBlocListener(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return TextFormField(
      controller: context.read<LoginCubit>().emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: S.of(context).Email,
        hintText: S.of(context).Email_hint,
        prefixIcon: SvgPicture.asset(
          "assets/svgs/email.svg",
          width: 25.w,
          height: 25.h,
          fit: BoxFit.scaleDown,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
          12.r,
        )),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey, width: 1.5.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.deepPurple, width: 1.5.w),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).email_validation;
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return TextFormField(
      controller: context.read<LoginCubit>().passwordController,
      obscureText: obscurePassword,
      decoration: InputDecoration(
        labelText: S.of(context).password,
        hintText: S.of(context).password_hint,
        suffixIcon: IconButton(
          icon: Icon(
            obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: onTogglePassword,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey, width: 1.5.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.deepPurple, width: 1.5.w),
        ),
      ),
      validator: (value) => (value == null || value.isEmpty)
          ? S.of(context).password_validation
          : null,
    );
  }

  Widget _buildRememberMeRow(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: rememberMe,
          onChanged: (value) => onRememberMeChanged(value!),
          checkColor: Colors.white,
          fillColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.selected)) {
              return const Color.fromRGBO(42, 49, 131, 1);
            }
            return Colors.transparent;
          }),
          side: const BorderSide(
            color: Color.fromRGBO(42, 49, 131, 1),
            width: 2,
          ),
        ),
        Text(
          S.of(context).Remember_Me,
          style: TextStyles.font14BlackSemiBold.copyWith(fontSize: 12.sp),
        ),
        // const Spacer(),
        // TextButton(
        //   onPressed: () {},
        //   child: Text(
        //     S.of(context).Forgot_Password,
        //     style: TextStyles.font11WhiteRegular.copyWith(
        //       color: const Color.fromRGBO(42, 49, 131, 1),
        //       fontSize: 12.sp,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return InkWell(
      onTap: () {
        validateThenLogin(context);
      },
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(42, 49, 131, 1),
              Color.fromRGBO(42, 49, 131, 1),
              Color.fromRGBO(91, 46, 212, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Center(
          child: Text(
            S.of(context).sign_text,
            style: TextStyles.font16WhiteSemiBold,
          ),
        ),
      ),
    );
  }
}

void validateThenLogin(BuildContext context) {
  if (context.read<LoginCubit>().formKey.currentState!.validate()) {
    LoginRequestBody loginRequestBody = LoginRequestBody(
      email: context.read<LoginCubit>().emailController.text,
      password: context.read<LoginCubit>().passwordController.text,
    );
    context.read<LoginCubit>().emitLogin(loginRequestBody);
  }
}
