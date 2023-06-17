part of '../recipe_list_page.dart';

class _RecipeListError extends _RecipeList {
  const _RecipeListError(this.error, this.stackTrace) : super(const []);

  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Placeholder();
  }
}
