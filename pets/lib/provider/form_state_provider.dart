import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final petFormStateProvider =
    StateProvider<GlobalKey<FormState>>((ref) => GlobalKey<FormState>());
