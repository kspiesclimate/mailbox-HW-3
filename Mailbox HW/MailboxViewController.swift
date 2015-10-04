//
//  MailboxViewController.swift
//  Mailbox HW
//
//  Created by Katie Spies on 9/29/15.
//  Copyright (c) 2015 Katie Spies. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBAction func dismissButtonAction(sender: AnyObject) {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            //dismiss the reschedule or list views
            self.rescheduleImage.alpha = 0
            self.rescheduleImage.frame.origin.y = 568
            self.listImage.alpha = 0
            self.listImage.frame.origin.y = 568
            self.listIcon.alpha = 0
            self.laterIcon.alpha = 0
            //return single message to origin
            self.dismissButtonOutlet.enabled = false
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.singleMessage.frame.origin.x = 0
            })
            

        })
        
    }
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var dismissButtonOutlet: UIButton!
    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var rescheduleImage: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var composeCancelOutlet: UIButton!
    @IBOutlet weak var composeView: UIImageView!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var singleMessage: UIImageView!
    //@IBOutlet weak var imageView: UIView! //view containing the feed and the message
    @IBOutlet weak var scrollView: UIScrollView!
    
    var MessageOriginalY: CGFloat!
    var MessageOriginalX: CGFloat!
    var RightPosition: CGFloat!
    var LeftPosition: CGFloat!
    var TotalOriginalX: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: 2150)
        
        listImage.alpha = 0
        rescheduleImage.alpha = 0
        menuImage.hidden = true
        composeView.hidden = true
        composeCancelOutlet.enabled = false
        self.deleteIcon.alpha = 0.2
        self.archiveIcon.alpha = 0.2
        self.laterIcon.alpha = 0.2
        self.listIcon.alpha = 0.2
        self.deleteIcon.hidden = true
        self.archiveIcon.hidden = true
        self.laterIcon.hidden = true
        self.listIcon.hidden = true
        rightImageView.backgroundColor = UIColor.grayColor()
        dismissButtonOutlet.enabled = false

        // Do any additional setup after loading the view.
    }
    
    @IBAction func panGestureRecognizer(sender: UIPanGestureRecognizer) {
        var location = sender.locationInView(view)
        NSLog("location \(location.x) \(location.y)")
        
        var translation = sender.translationInView(view)
        NSLog("translation \(translation.x) \(translation.y)")
        
        var velocity = sender.velocityInView(view)
        NSLog("velocity \(velocity.x) \(velocity.y)")

        
        if sender.state == UIGestureRecognizerState.Began {
            println("gesture began!")
            MessageOriginalY = singleMessage.frame.origin.y
            MessageOriginalX = singleMessage.frame.origin.x
        }
            
        else if sender.state == UIGestureRecognizerState.Changed{
            println("gesture changed!")
            
            singleMessage.frame.origin.x = MessageOriginalX + translation.x
            
            //drag left, not to 60
            if singleMessage.frame.origin.x < 0 && singleMessage.frame.origin.x > -60 {
                rightImageView.backgroundColor = UIColor.grayColor()
                laterIcon.hidden = false
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    //make reschedule/later icon opaque
                    self.laterIcon.alpha = 1
                })
            }
            //drag left, more than 60
            else if singleMessage.frame.origin.x < -60 && singleMessage.frame.origin.x > -260 {
                rightImageView.backgroundColor = UIColor.yellowColor()
                self.laterIcon.frame.origin.x = singleMessage.frame.origin.x + 340
                self.laterIcon.alpha = 1
                self.laterIcon.hidden = false
                self.listIcon.hidden = true
            }
            //drag left, more than 260
            else if singleMessage.frame.origin.x < -260 {
                rightImageView.backgroundColor = UIColor.brownColor()
                self.listIcon.hidden = false
                self.laterIcon.hidden = true
                self.listIcon.alpha = 1
                self.listIcon.frame.origin.x = singleMessage.frame.origin.x + 340
                
            }
            //drag right less than 60
            else if singleMessage.frame.origin.x > 0 && singleMessage.frame.origin.x < 60 {
                rightImageView.backgroundColor = UIColor.grayColor()
                archiveIcon.hidden = false
                deleteIcon.hidden = true
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    //make reschedule/later icon opaque
                    self.archiveIcon.alpha = 1
                })

            }
                
            //drag right more than 60
            else if singleMessage.frame.origin.x > 60 && singleMessage.frame.origin.x < 260 {
                rightImageView.backgroundColor = UIColor.greenColor()
                self.archiveIcon.frame.origin.x = singleMessage.frame.origin.x - 40
                self.archiveIcon.hidden = false
                self.deleteIcon.hidden = true
                self.archiveIcon.alpha = 1
            }
            //drag right more than 260
           else if singleMessage.frame.origin.x > 260 {
                rightImageView.backgroundColor = UIColor.redColor()
                self.archiveIcon.hidden = true
                self.deleteIcon.hidden = false
                self.deleteIcon.alpha = 1
                self.deleteIcon.frame.origin.x = singleMessage.frame.origin.x - 40
            }
        }
        else if sender.state == UIGestureRecognizerState.Ended{
            println("gesture ended!")
            println("singleMessage.frame.origin.x:  \(singleMessage.frame.origin.x)")
            
            //if released at < 60 then message should return to original position
            
           if singleMessage.frame.origin.x < 0 && singleMessage.frame.origin.x > -60 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.singleMessage.frame.origin.x = 0
                            self.deleteIcon.alpha = 0.2
                            self.archiveIcon.alpha = 0.2
                            self.laterIcon.alpha = 0.2
                            self.listIcon.alpha = 0.2
                            self.deleteIcon.hidden = true
                            self.archiveIcon.hidden = true
                            self.laterIcon.hidden = true
                            self.listIcon.hidden = true
                            self.rightImageView.backgroundColor = UIColor.grayColor()
               })
            }
             else if singleMessage.frame.origin.x < -60 && singleMessage.frame.origin.x > -260 {
                    //on release, continue showing yellow background
                    //on complete, show the reschedule options
                println("ended and going to yellow!")
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    //continue showing yellow
                    self.singleMessage.frame.origin.x = -290
                    self.laterIcon.frame.origin.x = 40
                }, completion: { (completed) -> Void in
                    //show reschedule options
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.rescheduleImage.alpha = 1
                        self.rescheduleImage.frame.origin.y = 0
                    }, completion: { (completed) -> Void in
                        //completed
                        self.dismissButtonOutlet.enabled = true
                    })
                })
            }
            
            else if singleMessage.frame.origin.x < -260 {
            //continue revealing brown background
            //open list view
            println("ended and going to brown")
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                //continue showing yellow
                self.singleMessage.frame.origin.x = -290
                self.listIcon.frame.origin.x = 40
                }, completion: { (completed) -> Void in
                    //show reschedule options
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.listImage.alpha = 1
                        self.listImage.frame.origin.y = 0
                        }, completion: { (completed) -> Void in
                            //completed
                            self.dismissButtonOutlet.enabled = true

                           
                    })
            })
            
            }
           //drag right less than 60
           else if singleMessage.frame.origin.x > 0 && singleMessage.frame.origin.x < 60 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.singleMessage.frame.origin.x = 0
                    self.deleteIcon.alpha = 0.2
                    self.archiveIcon.alpha = 0.2
                    self.laterIcon.alpha = 0.2
                    self.listIcon.alpha = 0.2
                    self.deleteIcon.hidden = true
                    self.archiveIcon.hidden = true
                    self.laterIcon.hidden = true
                    self.listIcon.hidden = true
                    self.rightImageView.backgroundColor = UIColor.grayColor()
                })

           }
          
            //drag right more than 60
           else if singleMessage.frame.origin.x > 60 && singleMessage.frame.origin.x < 260 {
            
            //continue displaying green
            //hide the message
                UIView.animateWithDuration(0.75, animations: { () -> Void in
                self.singleMessage.frame.origin.x = 340
                self.archiveIcon.frame.origin.x = 300
                self.feedImage.frame.origin.y = 0
                })

            
           }
            
            //drag right more than 260
           else if singleMessage.frame.origin.x > 260 {
            //continue displaying red
            //hide message
                UIView.animateWithDuration(0.75, animations: { () -> Void in
                self.singleMessage.frame.origin.x = 340
                self.deleteIcon.frame.origin.x = 300
                self.feedImage.frame.origin.y = 0
                })
            }
            
        }
    }
    
    @IBAction func messagePanGesture(sender: UIPanGestureRecognizer) {

        //on pulling right, move all of the view over and expose the menu
        menuImage.hidden = false
        
        var location = sender.locationInView(view)
        NSLog("location \(location.x) \(location.y)")
        
        var translation = sender.translationInView(view)
        NSLog("translation \(translation.x) \(translation.y)")
        
        var originalTapX: CGFloat!
        
        if sender.state == UIGestureRecognizerState.Began {
            println("gesture began!")
            TotalOriginalX = totalView.frame.origin.x
            
            //get location of original tap
            originalTapX = location.x
            
            //get difference between that location and the original center
        }
        else if sender.state == UIGestureRecognizerState.Changed{
            println("gesture changed!")
            if location.x < 280 {
            totalView.frame.origin.x = location.x
            }
        }
        else if sender.state == UIGestureRecognizerState.Ended{
            println("gesture ended!")
            
            if translation.x > 0 && location.x > 20 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    //continue exposing menu
                    self.totalView.frame.origin.x = 280
                })
            }
            else if translation.x < 0 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    //close menu
                    self.totalView.frame.origin.x = 0
                })
            }
        }
    
    }
    
    @IBAction func exposeCompose(sender: AnyObject) {
        UIView.animateWithDuration(0.75, animations: { () -> Void in
            //expose the compose view
                self.composeView.hidden = false
                self.composeView.frame.origin.y = 0
                self.composeCancelOutlet.enabled = true
                self.composeCancelOutlet.frame.origin.y = 46
            
        })
    }
    @IBAction func composeCancelAction(sender: AnyObject) {
     //animate dismissal of compose view
        UIView.animateWithDuration(0.75, animations: { () -> Void in
            //move compose view and button back down
            self.composeCancelOutlet.frame.origin.y = 614
            self.composeView.frame.origin.y = 568
        }) { (completed) -> Void in
            //re-hide images
            self.composeView.hidden = true
            self.composeCancelOutlet.enabled = false
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
