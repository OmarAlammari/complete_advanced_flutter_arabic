// ignore_for_file: constant_identifier_names

import '../network/error_handler.dart';

import '../response/responses.dart';

const CACHE_HOME_KEY = 'CACHE_HOME_KEY';
const CACHE_HOME_INTERVAL = 60 * 1000; // 1 minute cache in millisecond
const CACHE_STORE_DETAILS_KEY = 'CACHE_STORE_DETAILS_KEY';
const CACHE_STORE_DETAILS_INTERVAL = 60 * 1000; // 30s in millisecond

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();

  Future<void> saveHomeToCache(HomeResponse homeResponse);

  void clearCache();

  void removeFromCache(String key);

  Future<StoreDetailsResponse> getStoreDetails();

  Future<void> saveStoreDetailsToCache(StoreDetailsResponse response);
}

class LocalDataSourceImpl implements LocalDataSource {
  // run time cache
  Map<String, CachedItem> cacheMap = Map();

  @override
  Future<HomeResponse> getHomeData() async {
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      // return the response from cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }

  // @override
  // Future<StoreDetailsResponse> getStoreDetails() async {
  //   CachedItem? cachedItem = cacheMap[CACHE_STORE_DETAILS_KEY];

  //   if (cachedItem != null &&
  //       cachedItem.isValid(CACHE_STORE_DETAILS_INTERVAL)) {
  //     return cachedItem.data;
  //   } else {
  //     throw ErrorHandler.handle(DataSource.CACHE_ERROR);
  //   }
  // }

  // @override
  // Future<void> saveStoreDetailsToCache(StoreDetailsResponse response) async {
  //   cacheMap[CACHE_STORE_DETAILS_KEY] = CachedItem(response);
  // }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() {
    CachedItem? cachedItem = cacheMap[CACHE_STORE_DETAILS_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_STORE_DETAILS_INTERVAL)) {
      // return the response from cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveStoreDetailsToCache(StoreDetailsResponse response) async {
    cacheMap[CACHE_STORE_DETAILS_KEY] = CachedItem(response);
  }
}

class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeInMillisecond) {
    int currentTimeInMillisecond = DateTime.now().millisecondsSinceEpoch;

    bool isValid =
        currentTimeInMillisecond - cacheTime <= expirationTimeInMillisecond;
    // expirationTimeInMillisecond -> 60 sec
    // currentTimeInMillisecond -> 1:00:00
    // cacheTime -> 12:59:30
    // valid -> till 1:00:30
    return isValid;
  }
}
