import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pictures_finder/model/sent_session.dart';
import 'package:pictures_finder/repo/session_repository.dart';
import 'package:pictures_finder/ui/add_session/add_session_page.dart';
import 'package:pictures_finder/ui/check_session/check_session_dialog.dart';
import 'package:pictures_finder/ui/home_page/cubit/saved_session_cubit.dart';
import 'package:pictures_finder/ui/home_page/widgets/saved_session_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SavedSessionCubit(imageRepository: context.read<SessionRepository>()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picture Finder'),
      ),
      body: Builder(
        builder: (context) {
          final liveData =
              context.watch<SavedSessionCubit>().state.savedSessionLiveData;
          if (liveData?.value == null) {
            return const Center(
              child: Text('Initializing!!'),
            );
          }
          return ValueListenableBuilder<Box<SentSession>>(
            valueListenable: liveData!.value!,
            builder: (context, box, child) {
              if (box.isEmpty) {
                return const Center(
                  child: Text('You have not made any sessions yet'),
                );
              }
              return ListView.builder(
                itemCount: box.length,
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 32,
                  top: 8,
                ),
                itemBuilder: (context, index) {
                  final session = box.getAt(index);
                  return SavedSessionCard(
                    session: session,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return CheckSessionDialog(
                            session: session!,
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AddSessionPage(),
          ),
        ),
      ),
    );
  }
}
