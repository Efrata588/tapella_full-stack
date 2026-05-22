// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_listings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SavedListingsNotifier)
const savedListingsProvider = SavedListingsNotifierProvider._();

final class SavedListingsNotifierProvider
    extends $NotifierProvider<SavedListingsNotifier, Set<String>> {
  const SavedListingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedListingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedListingsNotifierHash();

  @$internal
  @override
  SavedListingsNotifier create() => SavedListingsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$savedListingsNotifierHash() =>
    r'2f216397c3563eef51d311fd84e620dfcf346f22';

abstract class _$SavedListingsNotifier extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
