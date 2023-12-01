import '../export_home.dart';
class ErrorLoading extends StatelessWidget {
  const ErrorLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomScrollView(
                    slivers: [MyAppBar()],
                  ),
                ),
                Expanded(
                    flex: 8,
                    child: Center(
                      child: Text("some error occurred "),
                    ))
              ],
            ),
            );
  }
}