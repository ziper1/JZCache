//
//  ViewController.swift
//  ExampleJZCache
//
//  Created by Jacek Zapart on 05.07.2014.
//  Copyright (c) 2014 Jacek Zapart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // sample function operates on Ints
    func intfunc (a: Int, b: Int) -> Int{
        sleep(1) // very expensive operation
        return a+b
    }
    
    // sample function operates on Strings
    func stringfunc (a: String, b: String, c:String) -> String{
        sleep(1) // very expensive operation
        return a+b+c
    }
   
    func makeIncrementor(forIncrement amount: Int) -> () -> Int {
        sleep(1) // very expensive operation
        var runningTotal = 0
        func incrementor() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //
        // EXAMPLE
        //
        
        // initialize
        let cache = JZCache()

        // instead of:
//      let result = intfunc(3, b: 5)
        // do:
        let result = cache.cache (intfunc, params: (3, b: 5))
        
        // instead of:
//      let result2 = stringfunc("aaa", b: "bbb", c: "ccc")
        // do:
        
        let result2 = cache.cache (stringfunc, params: ("aaa", b: "bbb", c: "ccc"))
        // instead of:
        //      let result2 = stringfunc("aaa", b: "bbb", c: "ccc")
        // do:
        let result3 = cache.cache (makeIncrementor, params: 3)
        
        let result4 = cache.cache (intfunc, params: (3, 5))
        
        cache.clearCache() // remove all values
        cache.clearInvalidCache() // remove old values
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

