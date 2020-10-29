# README

## Description

LRU Cache
An in memory cache implementation that expires the least recently used items, and limits cache size by a maximum number of items.
API
A cache object can be instantiated in memory. It requires the max number of records as an argument:
cache = Cache.new(max_count: 100)
An object may be written to a string cache key:
cache.write("key", value)
That object may be retrieved by a key, or nil is returned if it is not found:
cache.read("key") (O(1) )
A cached value may be deleted by key:
cache.delete("key") (O(1) )
All values may be deleted:
cache.clear
The number of records can be fetched at any time:
cache.count
Example:
cache = Cache.new(max_count: 3)
T0: cache.write('a', 1)
T1: cache.write('b', 2)
T3: cache.read('a') -> 1
T4: cache.write('c', 3)
T5: cache.write('d', 4) (removes 'b', 2)

## TODO LIST

DONE:
* implementations is working
* implementations is tested

TODO:
* refactory: extract methods 
* refactory: decrease the complexity 
