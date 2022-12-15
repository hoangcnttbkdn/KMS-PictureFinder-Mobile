import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:pictures_finder/common/enum/loading_status.dart';
import 'package:pictures_finder/common/extensions/build_context_extension.dart';
import 'package:pictures_finder/common/extensions/snackbar_extension.dart';
import 'package:pictures_finder/common/gen/assets.gen.dart';
import 'package:pictures_finder/model/find_type.dart';
import 'package:pictures_finder/model/sent_session.dart';
import 'package:pictures_finder/repo/session_repository.dart';
import 'package:pictures_finder/ui/view_result/cubit/view_result_cubit.dart';

class ViewResultPage extends StatelessWidget {
  const ViewResultPage({super.key, required this.session});

  final SentSession session;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewResultCubit(
        imageRepository: context.read<SessionRepository>(),
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
        title: const Text('Result'),
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
                        child: FittedBox(child: dataWidget(session: session)),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Found Images',
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
                    if (imageResults.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text('Not image found'),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: imageResults.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        final image = imageResults[index];
                        return GestureDetector(
                          onTap: () => context.pushToViewImage(image.url),
                          child: SizedBox(
                            height: 250,
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CachedNetworkImage(
                                    imageUrl: image.url,
                                    fit: BoxFit.cover,
                                    height: 250,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: context.colorScheme.surface
                                        .withOpacity(0.7),
                                    child: IconButton(
                                      icon: Assets.icons.download.svg(
                                        color: context.colorScheme.onSurface,
                                      ),
                                      onPressed: () async {
                                        await ImageDownloader.downloadImage(
                                          image.url,
                                        ).then((value) {
                                          context.showSnackBar(
                                            message: 'Saved image',
                                          );
                                        }).catchError((e, stacktrace) {
                                          log(e.toString());
                                          log(stacktrace.toString());

                                          context.showSnackBar(
                                            message: 'Error occured',
                                          );
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
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

  Widget dataWidget({required SentSession session}) {
    switch (session.findType) {
      case FindType.clothes:
      case FindType.face:
        return Image.file(
          File(session.data),
          fit: BoxFit.cover,
        );
      case FindType.bib:
        return Text(session.data);
    }
  }
}
