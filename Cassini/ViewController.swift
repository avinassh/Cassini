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
                    case "Moon":
                        ivc.imageURL = DemoURL.NASA.Moon
                        ivc.title = "Moon"
                    default: break
                }
            }
        }
    }
    
    
    @IBAction func sendToMoon() {
        performSegueWithIdentifier("Moon", sender: nil)
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

extension DemoURL.NASA {
    static let Moon = NSURL(string: "http://i.imgur.com/7nNGcdE.jpg")
}