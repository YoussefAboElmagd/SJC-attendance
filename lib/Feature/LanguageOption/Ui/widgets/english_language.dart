import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
import 'package:madarj/Core/helpers/lang_enum.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/generated/l10n.dart';

class EnglishLanguage extends StatelessWidget {
  const EnglishLanguage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationCubit, ApplicationState>(
      builder: (context, state) {
        return InkWell(
          focusColor: Colors.white,
          hoverColor: Colors.white,
          highlightColor: Colors.white,
          splashColor: Colors.white,
          onTap: () {
            ApplicationCubit.get(context).getLanguage(LangEnum.en);
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                child: Row(
                  children: [
                    Text(
                      S.of(context).lang_en,
                      style: TextStyles.font18BlackBold,
                    ),
                    const Spacer(),
                    ApplicationCubit.get(context).isArabic
                        ? Container()
                        : const Image(
                          image: AssetImage("assets/images/check.png"),
                        ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
