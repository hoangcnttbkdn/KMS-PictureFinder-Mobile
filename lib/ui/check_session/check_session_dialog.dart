import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictures_finder/common/enum/loading_status.dart';
import 'package:pictures_finder/common/widgets/fill_button.dart';
import 'package:pictures_finder/model/sent_session.dart';
import 'package:pictures_finder/repo/session_repository.dart';
import 'package:pictures_finder/ui/check_session/cubit/check_session_cubit.dart';
import 'package:pictures_finder/ui/view_result/view_result_page.dart';

class CheckSessionDialog extends StatelessWidget {
  const CheckSessionDialog({super.key, required this.session});

  final SentSession session;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckSessionCubit(
        session: session,
        imageRepository: context.read<SessionRepository>(),
      ),
      child: const CheckSessionDialogView(),
    );
  }
}

class CheckSessionDialogView extends StatelessWidget {
  const CheckSessionDialogView({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Searching Status'),
      content: Column(  
        mainAxisSize: MainAxisSize.min,
        children: [
          Builder(
            builder: (context) {
              final loadingStatus = context
                  .select((CheckSessionCubit bloc) => bloc.state.loadingStatus);
              final result =
                  context.select((CheckSessionCubit bloc) => bloc.state.result);
              if (loadingStatus == LoadingStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (loadingStatus == LoadingStatus.error) {
                return const Text('An error occurred, please try again');
              }
              return Text(
                result!.value.isFinished
                    ? 'Search results are available'
                    : 'There are currently no search results, please come back',
              );
            },
          ),
        ],
      ),
      actions: [
        Builder(
          builder: (context) {
            final result =
                context.select((CheckSessionCubit bloc) => bloc.state.result);
            final session =
                context.select((CheckSessionCubit bloc) => bloc.state.session);
            final canPress = result == null ? false : result.value.isFinished;
            return FilledButton(
              onPressed: canPress
                  ? () {
                      Navigator.of(context)
                        ..pop()
                        ..push(
                          MaterialPageRoute(
                            builder: (_) => ViewResultPage(
                              session: session,
                            ),
                          ),
                        );
                    }
                  : null,
              child: const Text('View result'),
            );
          },
        ),
        TextButton(
          child: const Text('Close'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}
