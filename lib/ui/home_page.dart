import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pictures_finder/common/enum/loading_status.dart';
import 'package:pictures_finder/repo/image_repository.dart';
import 'package:pictures_finder/ui/cubit/facebook_cubit.dart';
import 'package:pictures_finder/ui/cubit/google_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Pictures Finder'),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: SvgPicture.asset(
                    'assets/icons/ic_google.svg',
                    height: 32,
                  ),
                ),
                Tab(
                  icon: SvgPicture.asset(
                    'assets/icons/ic_facebook.svg',
                    height: 32,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              BlocProvider(
                create: (context) => GoogleCubit(
                  imageRepository: context.read<ImageRepository>(),
                ),
                child: const GoogleView(),
              ),
              BlocProvider(
                create: (context) =>
                    FacebookCubit(context.read<ImageRepository>()),
                child: const FacebookView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FacebookView extends StatelessWidget {
  const FacebookView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Access Token',
            ),
            onChanged: (value) =>
                context.read<FacebookCubit>().changeAccessToken(value),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Cookie',
            ),
            onChanged: (value) =>
                context.read<FacebookCubit>().changeCookie(value),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'AlbumUrl',
            ),
            onChanged: (value) =>
                context.read<FacebookCubit>().changeAlbumUrl(value),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text('Lấy ảnh'),
            onPressed: () =>
                context.read<FacebookCubit>().pickImageFromGallery(),
          ),
          BlocBuilder<FacebookCubit, FacebookState>(
            buildWhen: (previous, current) =>
                previous.imagePath != current.imagePath,
            builder: (context, state) {
              if (state.imagePath.isEmpty) {
                return const SizedBox();
              }
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: AspectRatio(
                  aspectRatio: 1.2,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.file(
                          File(state.imagePath),
                          fit: BoxFit.cover,
                        ).image,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<FacebookCubit, FacebookState>(
            buildWhen: (previous, current) =>
                previous.imagePath != current.imagePath,
            builder: (context, state) {
              if (state.imagePath.isEmpty) {
                return const SizedBox();
              }
              return ElevatedButton(
                child: const Text('Get go'),
                onPressed: () => context.read<FacebookCubit>().findImages(),
              );
            },
          ),
          BlocBuilder<FacebookCubit, FacebookState>(
            buildWhen: (previous, current) =>
                previous.loadingStatus != current.loadingStatus ||
                previous.imageResult != current.imageResult,
            builder: (context, state) {
              final loadingStatus = state.loadingStatus;
              final imageResult = state.imageResult;
              if (loadingStatus == LoadingStatus.initial) {
                return const SizedBox();
              }
              if (loadingStatus == LoadingStatus.loading) {
                return const CircularProgressIndicator();
              }
              if (loadingStatus == LoadingStatus.error) {
                return const Text('Có lỗi xảy ra, vui lòng thử  lại');
              }
              if (imageResult.isEmpty) {
                return const Text('Không có ảnh nào được tìm thấy');
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kết quả',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: imageResult.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                    ),
                    itemBuilder: (context, index) {
                      final image = imageResult[index];
                      return Image.network(
                        image.url,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class GoogleView extends StatelessWidget {
  const GoogleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'FolderUrl',
            ),
            onChanged: (value) =>
                context.read<GoogleCubit>().changeFolder(folderPath: value),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text('Lấy ảnh'),
            onPressed: () => context.read<GoogleCubit>().pickImageFromGallery(),
          ),
          BlocBuilder<GoogleCubit, GoogleState>(
            buildWhen: (previous, current) =>
                previous.imagePath != current.imagePath,
            builder: (context, state) {
              if (state.imagePath.isEmpty) {
                return const SizedBox();
              }
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: AspectRatio(
                  aspectRatio: 1.2,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.file(
                          File(state.imagePath),
                          fit: BoxFit.cover,
                        ).image,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<GoogleCubit, GoogleState>(
            buildWhen: (previous, current) =>
                previous.imagePath != current.imagePath,
            builder: (context, state) {
              if (state.imagePath.isEmpty) {
                return const SizedBox();
              }
              return ElevatedButton(
                child: const Text('Get go'),
                onPressed: () => context.read<GoogleCubit>().findImages(),
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<GoogleCubit, GoogleState>(
            buildWhen: (previous, current) =>
                previous.loadingStatus != current.loadingStatus ||
                previous.imageResult != current.imageResult,
            builder: (context, state) {
              final loadingStatus = state.loadingStatus;
              final imageResult = state.imageResult;
              if (loadingStatus == LoadingStatus.initial) {
                return const SizedBox();
              }
              if (loadingStatus == LoadingStatus.loading) {
                return const CircularProgressIndicator();
              }
              if (loadingStatus == LoadingStatus.error) {
                return const Text('Có lỗi xảy ra, vui lòng thử  lại');
              }
              if (imageResult.isEmpty) {
                return const Text('Không có ảnh nào được tìm thấy');
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kết quả',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: imageResult.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                    ),
                    itemBuilder: (context, index) {
                      final image = imageResult[index];
                      return Image.network(
                        image.url,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
