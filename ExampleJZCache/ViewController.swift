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
        sleep(1)
        return a+b
    }
    
    // sample function operates on Strings
    func stringfunc (a: String, b: String, c:String) -> String{
        return a+b+c
    }
   
    func makeIncrementor(forIncrement amount: Int) -> () -> Int {
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
        
        // some examples
        let cache = JZCache()
        let result = cache.cache (intfunc, params: (3, 5))
        let bresult = cache.cache (stringfunc, params: ("aaa", "bbb", "ccc"))
        let cresult = cache.cache (makeIncrementor, params: 3)
        let result2 = cache.cache (intfunc, params: (3, 5))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

