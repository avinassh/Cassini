//
//  ViewController.swift
//  Cassini
//
//  Created by avi on 02/03/15.
//  Copyright (c) 2015 avi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let ivc = segue.destinationViewController as? ImageViewController {
            if let identtifier = segue.identifier {
                switch identtifier {
                    case "Earth":
                        ivc.imageURL = DemoURL.NASA.Earth
                        ivc.title = "Earth"
                    case "Cassini":
                        ivc.imageURL = DemoURL.NASA.Cassini
                        ivc.title = "Cassini"
                    case "Saturn":
                        ivc.imageURL = DemoURL.NASA.Saturn
                        ivc.title = "Saturn"
                    default: break
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

