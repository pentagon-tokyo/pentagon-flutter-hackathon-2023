import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:satorist/service/stress_check_service.dart';
import 'package:satorist/ui/design/my_colors.dart';
import 'package:satorist/ui/screen/stress_check_loading/stress_check_loading_screen.dart';

import '../../../util/app_router.dart';
import '../../component/accept_button.dart';
import '../../design/spaces.dart';

class StressCheckResultScreen extends ConsumerWidget {
  const StressCheckResultScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(stressCheckResultProvider).when(
          loading: () => const StressCheckLoadingScreen(),
          error: (_, __) => const SizedBox.shrink(),
          data: (stressValue) => Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              leading: const CloseButton(),
              elevation: 0,
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '現在のストレス値：$stressValue％',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: 1,
                    width: 170,
                    color: Colors.white,
                  ),
                  spaceH48,
                  Text(
                    'あなたの\nストレスを解消するには',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  spaceH16,
                  Container(
                    width: 140,
                    height: 100,
                    decoration: BoxDecoration(
                      color: MyColors.grey800.color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'コース',
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.white,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          stressValue.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  spaceH16,
                  Text(
                    'の瞑想が必要です！',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  spaceH48,
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: AcceptButton(
                        label: 'つぎへ',
                        onPressed: () {
                          GoRouter.of(context).push(
                            AppRouter.faceDetector,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
