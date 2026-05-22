// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Listings)
const listingsProvider = ListingsProvider._();

final class ListingsProvider
    extends $NotifierProvider<Listings, ListingsState> {
  const ListingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'listingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$listingsHash();

  @$internal
  @override
  Listings create() => Listings();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ListingsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ListingsState>(value),
    );
  }
}

String _$listingsHash() => r'd15d5534c16abc42362b1fa7f444bdbe91fba2b7';

abstract class _$Listings extends $Notifier<ListingsState> {
  ListingsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ListingsState, ListingsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ListingsState, ListingsState>,
              ListingsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(listingDetail)
const listingDetailProvider = ListingDetailFamily._();

final class ListingDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<CacheResult<ListingModel>>,
          CacheResult<ListingModel>,
          FutureOr<CacheResult<ListingModel>>
        >
    with
        $FutureModifier<CacheResult<ListingModel>>,
        $FutureProvider<CacheResult<ListingModel>> {
  const ListingDetailProvider._({
    required ListingDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'listingDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$listingDetailHash();

  @override
  String toString() {
    return r'listingDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CacheResult<ListingModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CacheResult<ListingModel>> create(Ref ref) {
    final argument = this.argument as String;
    return listingDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ListingDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$listingDetailHash() => r'cf859ca71bb2f70e806c779383f1ba68b47978fa';

final class ListingDetailFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<CacheResult<ListingModel>>, String> {
  const ListingDetailFamily._()
    : super(
        retry: null,
        name: r'listingDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ListingDetailProvider call(String id) =>
      ListingDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'listingDetailProvider';
}

@ProviderFor(myListings)
const myListingsProvider = MyListingsProvider._();

final class MyListingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ListingModel>>,
          List<ListingModel>,
          FutureOr<List<ListingModel>>
        >
    with
        $FutureModifier<List<ListingModel>>,
        $FutureProvider<List<ListingModel>> {
  const MyListingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myListingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myListingsHash();

  @$internal
  @override
  $FutureProviderElement<List<ListingModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ListingModel>> create(Ref ref) {
    return myListings(ref);
  }
}

String _$myListingsHash() => r'cb1b3179e684f15693a99ef4066cc498ba12e9c7';

@ProviderFor(CreateListing)
const createListingProvider = CreateListingProvider._();

final class CreateListingProvider
    extends $AsyncNotifierProvider<CreateListing, void> {
  const CreateListingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createListingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createListingHash();

  @$internal
  @override
  CreateListing create() => CreateListing();
}

String _$createListingHash() => r'6cc7ec48de93cce7bc9df661f92e992b94c8fdc6';

abstract class _$CreateListing extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
