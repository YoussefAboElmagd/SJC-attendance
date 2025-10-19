import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:madarj/Core/helpers/cache_helper.dart';
import 'package:madarj/Core/helpers/language_bottom_sheet.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/registration/login/Logic/cubit/login_cubit.dart';
import 'package:madarj/Feature/registration/login/Logic/cubit/login_state.dart';
import 'package:madarj/Feature/registration/login/Ui/widgets/login_bloc_listener.dart';
import 'package:madarj/Feature/registration/login/Ui/widgets/user_selection_bottom_sheet.dart';
import 'package:madarj/Feature/registration/login/data/model/login_request_body.dart';
import 'package:madarj/generated/l10n.dart';

class LoginForm extends StatefulWidget {
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
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final FocusNode _emailFocus;
  late final FocusNode _passwordFocus;
  bool _isLoadingCredentials = false;
  bool _hasSavedUsers = false;
  @override
  void initState() {
    super.initState();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _loadSavedCredentials();
    _checkSavedUsers();
  }

  void _loadSavedCredentials() async {
    setState(() => _isLoadingCredentials = true);
    await context.read<LoginCubit>().loadSavedCredentials();
    setState(() => _isLoadingCredentials = false);
  }

  void _checkSavedUsers() async {
    final hasUsers = await context.read<LoginCubit>().hasSavedUsers();
    setState(() => _hasSavedUsers = hasUsers);
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

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
                  Text(
                    S.of(context).sign_text,
                    style: TextStyles.font32BlackBold,
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    S.of(context).sign_sub_text,
                    style: TextStyles.font14GreyRegular,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.h),

                  if (_isLoadingCredentials)
                    _buildLoadingIndicator()
                  else
                    _buildFormFields(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 100.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Column(
      children: [
        _buildEmailField(context, context.read<LoginCubit>()),
        SizedBox(height: 20.h),
        _buildPasswordField(context),
        _buildRememberMeRow(context),
        SizedBox(height: 20.h),
        _buildSignInButton(context),
        SizedBox(height: 20.h),
        _buildChangeLanguageButton(context),
        const LoginBlocListener(),
      ],
    );
  }

  Widget _buildEmailField(BuildContext context, var cubit) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextFormField(
          focusNode: _emailFocus,
          controller: context.read<LoginCubit>().emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_passwordFocus);
          },
          decoration: InputDecoration(
            labelText: S.of(context).Email,
            hintText: S.of(context).Email_hint,
            prefixIcon: Padding(
              padding: EdgeInsets.all(12.0.w),
              child: SvgPicture.asset(
                "assets/svgs/email.svg",
                width: 20.w,
                height: 20.h,
                fit: BoxFit.scaleDown,
              ),
            ),
            suffixIcon:
                _hasSavedUsers
                    ? _buildSavedUsersButton(
                      context,
                      context.read<LoginCubit>(),
                    )
                    : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.deepPurple, width: 1.5.w),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red, width: 1.5.w),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red, width: 1.5.w),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).email_validation;
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildSavedUsersButton(BuildContext context, var cubit) {
    return IconButton(
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.grey.shade600,
        size: 24.w,
      ),
      onPressed: () => _showUserSelectionBottomSheet(context, cubit),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextFormField(
          focusNode: _passwordFocus,
          controller: context.read<LoginCubit>().passwordController,
          obscureText: widget.obscurePassword,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) {
            _unfocusAllFields();
            _validateThenLogin();
          },
          decoration: InputDecoration(
            labelText: S.of(context).password,
            hintText: S.of(context).password_hint,

            prefixIcon: Padding(
              padding: EdgeInsets.all(12.0.w),
              child: const Icon(
                Icons.password,
                color: ColorsManager.mainColor1,
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                widget.obscurePassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey.shade600,
                size: 20.w,
              ),
              onPressed: widget.onTogglePassword,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.deepPurple, width: 1.5.w),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red, width: 1.5.w),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red, width: 1.5.w),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).password_validation;
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildRememberMeRow(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Row(
      children: [
        if (!isArabic) _buildRememberMeCheckbox(),

        Text(
          S.of(context).Remember_Me,
          style: TextStyles.font14BlackSemiBold.copyWith(fontSize: 14.sp),
        ),

        if (isArabic) _buildRememberMeCheckbox(),

        const Spacer(),

        if (_hasSavedUsers)
          TextButton(
            onPressed: _clearSavedCredentials,
            child: Text(
              S.of(context).clear_saved_credentials,
              style: TextStyles.font14BlueRegular.copyWith(fontSize: 12.sp),
            ),
          ),
      ],
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Checkbox(
      value: widget.rememberMe,
      onChanged: (value) => widget.onRememberMeChanged(value!),
      checkColor: Colors.white,
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color.fromRGBO(42, 49, 131, 1);
        }
        return Colors.transparent;
      }),
      side: const BorderSide(color: Color.fromRGBO(42, 49, 131, 1), width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return InkWell(
          onTap: isLoading ? null : _validateThenLogin,
          borderRadius: BorderRadius.circular(30.r),
          child: Container(
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(42, 49, 131, 1),
                  Color.fromRGBO(42, 49, 131, 0.9),
                  Color.fromRGBO(91, 46, 212, 1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.shade300.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child:
                  isLoading
                      ? SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).sign_text,
                            style: TextStyles.font16WhiteSemiBold.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 18.w,
                          ),
                        ],
                      ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChangeLanguageButton(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: Colors.blue.shade100, width: 1.w),
      ),
      child: GestureDetector(
        onTap: () {
          _unfocusAllFields();
          // context.pushNamed(Routes.language);
          openLanguageSheet(context);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.0.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children:
                isArabic
                    ? [
                      CircleAvatar(
                        radius: 16.w,
                        backgroundColor: Colors.blue.shade50,
                        child: SvgPicture.asset(
                          "assets/svgs/language.svg",
                          width: 16.w,
                          height: 16.h,
                          colorFilter: const ColorFilter.mode(
                            Colors.blue,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        S.of(context).change_language_button,
                        style: TextStyles.font14BlueSemiBold.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                    ]
                    : [
                      Text(
                        S.of(context).change_language_button,
                        style: TextStyles.font14BlueSemiBold.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      CircleAvatar(
                        radius: 16.w,
                        backgroundColor: Colors.blue.shade50,
                        child: SvgPicture.asset(
                          "assets/svgs/language.svg",
                          width: 16.w,
                          height: 16.h,
                          colorFilter: const ColorFilter.mode(
                            Colors.blue,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
          ),
        ),
      ),
    );
  }

  void _showUserSelectionBottomSheet(BuildContext context, LoginCubit cubit) {
    _unfocusAllFields();

    final parentContext = context;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder:
          (bottomSheetContext) => BlocProvider.value(
            value: cubit,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: UserSelectionBottomSheet(
                onUserSelected: (email, password) {
                  cubit.emailController.text = email;
                  cubit.passwordController.text = password;
                },
                onAddNewUser: () {
                  cubit.clearForm();
                },
              ),
            ),
          ),
    ).then((_) {
      _checkSavedUsers();
    });
  }

  void _clearSavedCredentials() async {
    // Capture the cubit reference before async operations
    final cubit = context.read<LoginCubit>();

    try {
      await CacheHelper.clearAllUsers();

      // Use the captured cubit reference
      cubit.clearForm();
      widget.onRememberMeChanged(false);

      setState(() {
        _hasSavedUsers = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).credentials_cleared),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Error clearing credentials'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        );
      }
    }
  }

  void _unfocusAllFields() {
    _emailFocus.unfocus();
    _passwordFocus.unfocus();
    FocusScope.of(context).unfocus();
  }

  void _validateThenLogin() {
    final cubit = context.read<LoginCubit>();
    if (cubit.formKey.currentState!.validate()) {
      LoginRequestBody loginRequestBody = LoginRequestBody(
        email: cubit.emailController.text.trim(),
        password: cubit.passwordController.text,
      );

      // Save user credentials if remember me is enabled
      // if (widget.rememberMe) {
      // cubit.saveUserCredentials(
      //   email: loginRequestBody.email,
      //   password: loginRequestBody.password,
      //   rememberMe: true,
      // );
      // }

      cubit.emitLogin(context, loginRequestBody);
    } else {
      // Show error message if validation fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fix the errors above'),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      );
    }
  }
}
