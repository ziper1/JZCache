JZCache
=======

Simple Swift interface for cache method calls.


How to use
----------

1. Create JZCache object:
```
JZCache myCache = JZCache()
```

2. instead of:
```
myMethod(parameters)
```

call:
```
cache.cache(myMethod, parameters)
```


