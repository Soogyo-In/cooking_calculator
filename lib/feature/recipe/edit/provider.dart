import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recipeProvider = StateProvider<Recipe>((ref) => const Recipe());
