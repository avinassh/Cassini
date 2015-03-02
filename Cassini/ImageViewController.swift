//
//  ImageViewController.swift
//  Cassini
//
//  Created by avi on 02/03/15.
//  Copyright (c) 2015 avi. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    private var imageView = UIImageView()
    private var image: UIImage? {
        get { return imageView.image }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            // we have to set the scroll view content size everytime a new 
            // image is set
            // making scrollview optional unwrapping, in case we try to set 
            // before actually outlets are set
            scrollView?.contentSize = imageView.frame.size
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
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            // its very very important to set content size of scroll view
            // so we set the scrollview's content size to exact size of our image
            scrollView.contentSize = imageView.frame.size
            
            // following code adds zooming capability
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    private func fetchImage() {
        if let url = imageURL {
            // code for multithreaded url image fetching
            //
            // set the quality of service. will go with user_initiated, since
            // user is requesting something
            //
            // this ugly line is due to historical reasons 😤
            let qos = Int(QOS_CLASS_USER_INITIATED.value)
            // get the queue and send the function/closure
            dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
                // following is a thread blocking operation
                // thats why were dispatching to another thread
                let imageData = NSData(contentsOfURL: url)
                
                // following is UI work, so lets dispatch it to main queue back
                
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                
                // following chekcs if the requested url is same as the image we 
                // fetched. Ugh...why it is required? Not required in this project
                // since we are segueing and the requested image will same as 
                // feteched image (since new MVC is created everytime). However 
                // in some cases when image is still being fetched but if user 
                // requests new another image (on same MVC), then without checking
                // the url, the fetched data may be of image of earlier request
                // so it may show different image!
                //
                // in our case, everytime we go back and forth, the MVC will
                // be thrown out, new one will be created and image will be
                // requested again!
                    if url == self.imageURL {
                        if imageData != nil {
                            self.image = UIImage(data: imageData!)
                        } else {
                            self.image = nil
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // lets add the image as a subview to scroll view
        // view.addSubview(imageView)
        scrollView.addSubview(imageView)

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
    
    // following says which view inside scrollview needs zooming
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
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
