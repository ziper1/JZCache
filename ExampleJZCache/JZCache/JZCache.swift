//
//  JZCache.swift
//  ExampleJZCache
//
//  Created by Jacek Zapart on 05.07.2014.
//  Copyright (c) 2014 Jacek Zapart. All rights reserved.
//

import Foundation

class JZCache
{
    let store = NSCache();
    var alternativeStore: Dictionary<String, Any> = Dictionary<String, Any>()
    var lastUpdate: Dictionary<String, NSDate> = Dictionary<String, NSDate>()
    var maxTime: NSTimeInterval?

    init(){
        self.maxTime = NSTimeInterval(300)
    }
    
    init(invalidateAfter: NSTimeInterval){
        self.maxTime = invalidateAfter
    }
    
    func cache <T, S> (function: (T -> S), params: T ) -> S {
        let key:String = self.createKey(function, params: params)
        
        // read
//        let cachedValue = self.read(key)
        // alternative
        let stored: (cachedValue: Any?, shouldInvalidate: Bool) = read(key)
        if stored.cachedValue != nil && stored.shouldInvalidate == false
        {
            println("returned cached value: " + toString(stored.cachedValue))
            return stored.cachedValue as S
        }
        
        let result = function(params)
        
        // save result
        self.save(result, forKey:key)
        
        return result
    }
    
    func createKey<T, S> (function: (T -> S), params: T ) -> String {
        println("Key: " + toString(params))
        // TODO: do some magic here to pass function name
        return toString(params)
    }
    
    @objc func shouldInvalidate (key: String) -> Bool
    {
        let last = lastUpdate[key]
        
        if (last){
            let interval = NSDate().timeIntervalSinceDate(last)
            if (interval > maxTime){
                return true
            }
        }
        
        return false
    }
    
    func save(value: Any, forKey: String)
    {
        println("save to cache: " + toString(value))
        alternativeStore.updateValue(value, forKey: forKey)
        lastUpdate.updateValue(NSDate(), forKey: forKey)
    }
    
    func read(key: String) -> (Any?, Bool)
    {
        return (alternativeStore[key], shouldInvalidate(key))
    }
    
    // some problems with casting type S to AnyObject and calling the NSCache methods
//    @objc func read(key: AnyObject) -> AnyObject {
//        return store.objectForKey(key) // use tuple function, params as key
//    }
//    
//    @objc func save(value: AnyObject, forKey: AnyObject) {
//        store.setObject(value, forKey: forKey) // use tuple function, params as key
//    }
    
    
}
