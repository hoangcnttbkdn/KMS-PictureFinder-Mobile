import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictures_finder/repo/image_repository.dart';
import 'package:pictures_finder/ui/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(imageRepository: context.read<ImageRepository>()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pictures Finder'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'FolderUrl',
                ),
                onChanged: (value) =>
                    context.read<HomeCubit>().changeFolder(folderPath: value),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Lấy ảnh'),
                onPressed: () =>
                    context.read<HomeCubit>().pickImageFromGallery(),
              ),
              BlocBuilder<HomeCubit, HomeState>(
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
              BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) =>
                    previous.imagePath != current.imagePath,
                builder: (context, state) {
                  if (state.imagePath.isEmpty) {
                    return const SizedBox();
                  }
                  return ElevatedButton(
                    child: const Text('Get go'),
                    onPressed: () => context.read<HomeCubit>().findImages(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
