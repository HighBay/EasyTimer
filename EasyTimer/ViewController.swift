//
//  ViewController.swift
//  EasyTimer
//
//  Created by Niklas Fahl on 3/2/16.
//  Copyright © 2016 High Bay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // EXAMPLES
        
        // Repeat but also execute once immediately
        let _ = 2.second.interval {
            print("Repeat every 2 seconds but also execute once right away.")
        }
        
        let _ = 2.second.interval { (timer: Timer) -> Void in
            print("Repeat every 2 seconds but also execute once right away.")
        }
        
        // Repeat after delay
        let timer2 = 2.second.delayedInterval { () -> Void in
            print("Repeat every 2 seconds after 2 second delay.")
        }
        timer2.stop()
        
        // Delay something
        let _ = 2.second.delay { () -> Void in
            print("2 seconds later...")
        }
        
        // Essentially equivalent to delayedInterval
        let timer = 3.minute.timer(repeats: true, delays: true) {
            print("3 minutes later...")
        }
        timer.start()
    }

    func doSomething() {
        print("Hello")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
