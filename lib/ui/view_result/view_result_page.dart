import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictures_finder/common/enum/loading_status.dart';
import 'package:pictures_finder/common/extensions/build_context_extension.dart';
import 'package:pictures_finder/model/sent_session.dart';
import 'package:pictures_finder/repo/image_repository.dart';
import 'package:pictures_finder/ui/view_result/cubit/view_result_cubit.dart';

class ViewResultPage extends StatelessWidget {
  const ViewResultPage({super.key, required this.session});

  final SentSession session;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewResultCubit(
        imageRepository: context.read<ImageRepository>(),
        sentSession: session,
      ),
      child: const ViewResultView(),
    );
  }
}

class ViewResultView extends StatelessWidget {
  const ViewResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kết quả'),
      ),
      body: BlocBuilder<ViewResultCubit, ViewResultState>(
        buildWhen: (previous, current) =>
            previous.loadingStatus != current.loadingStatus,
        builder: (context, state) {
          if (state.loadingStatus == LoadingStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.loadingStatus == LoadingStatus.error) {
            return const Center(
              child: Text('Error'),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Builder(
                    builder: (context) {
                      final session = context.select(
                        (ViewResultCubit bloc) => bloc.state.sentSession,
                      );
                      return SizedBox(
                        height: 150,
                        child: Image.file(File(session.imagePath)),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Kết quả tìm kiếm',
                  style: context.textTheme.titleLarge
                      ?.copyWith(color: context.colorScheme.onSurface),
                ),
                const SizedBox(
                  height: 16,
                ),
                Builder(
                  builder: (context) {
                    final imageResults = context.select(
                      (ViewResultCubit bloc) => bloc.state.imageResults,
                    );
                    return GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: imageResults.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                      ),
                      itemBuilder: (context, index) {
                        final image = imageResults[index];
                        return Image.network(
                          image.url,
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
