// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$uuidHash() => r'53770ce0d9bc99faf1d819cb93ff1014c54fd7d2';

/// See also [uuid].
@ProviderFor(uuid)
final uuidProvider = AutoDisposeProvider<Uuid>.internal(
  uuid,
  name: r'uuidProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$uuidHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UuidRef = AutoDisposeProviderRef<Uuid>;
String _$taskBoxHash() => r'cd7eb21b9cb7804376c80445a64ddec2cabe21fc';

/// See also [taskBox].
@ProviderFor(taskBox)
final taskBoxProvider = AutoDisposeFutureProvider<Box<Task>>.internal(
  taskBox,
  name: r'taskBoxProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$taskBoxHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TaskBoxRef = AutoDisposeFutureProviderRef<Box<Task>>;
String _$taskRepositoryHash() => r'ac279731bafb4c99bf5c306abe71fc0c3f22f7f8';

/// See also [taskRepository].
@ProviderFor(taskRepository)
final taskRepositoryProvider = AutoDisposeProvider<TaskRepository>.internal(
  taskRepository,
  name: r'taskRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$taskRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TaskRepositoryRef = AutoDisposeProviderRef<TaskRepository>;
String _$taskListHash() => r'cf59c53455719f69d1488ad5cb9d7cd219df13da';

/// See also [TaskList].
@ProviderFor(TaskList)
final taskListProvider =
    AutoDisposeNotifierProvider<TaskList, List<Task>>.internal(
  TaskList.new,
  name: r'taskListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$taskListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TaskList = AutoDisposeNotifier<List<Task>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
