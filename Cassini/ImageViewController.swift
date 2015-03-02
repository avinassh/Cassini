//
//  ImageViewController.swift
//  Cassini
//
//  Created by avi on 02/03/15.
//  Copyright (c) 2015 avi. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    private var imageView = UIImageView()
    private var image: UIImage? {
        get { return imageView.image }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    // model of this MVC
    var imageURL: NSURL? {
        didSet {
            image = nil
            // don't call fetch image if this MVC is not currently onscreen
            // (now it won't be called even if comes on screen)
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    private func fetchImage() {
        if let url = imageURL {
            let imageData = NSData(contentsOfURL: url)
            if imageData != nil {
                image = UIImage(data: imageData!)
            } else {
                image = nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(imageView)
        
        // following is not needed now since we are passing image url in segue
        //
        // since viewDidLoad is run after segue prep, following overwrites the
        // image url
        //
        // load some image
        // if image == nil {
        //    imageURL = DemoURL.Stanford
        // }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // this will be called whenever view is about to appear
        // we only need to call if image is nil. If we already have image
        // then no need to fetch it
        if image == nil {
            fetchImage()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
