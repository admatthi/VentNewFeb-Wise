//
//  OverviewViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 11/5/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Kingfisher
import FBSDKCoreKit
var selectedauthorname = String()
var selectedprofession = String()
var selectedbackground = String()

class OverviewViewController: UIViewController {
    
    func logBookOpened(referrer : String) {
             AppEvents.logEvent(AppEvents.Name(rawValue: "favorite tapped"), parameters: ["referrer" : referrer, "bookid" : selectedbookid])
         }

    @IBOutlet weak var tapstart: UIButton!
    @IBAction func tapStart(_ sender: Any) {
        
        logBookOpened(referrer: referrer)
        
        if didpurchase {
            
            randomString = NSUUID().uuidString
            
            self.performSegue(withIdentifier: "OverviewToWrite3", sender: self)
        } else {
            
            self.performSegue(withIdentifier: "OverviewToSale", sender: self)

        }
    }
    
    
    @IBOutlet weak var authorimage: UIImageView!
    @IBOutlet weak var blurredimage: UIImageView!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var professionlabel: UILabel!
    @IBOutlet weak var backimagel: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var authorlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapstart.layer.cornerRadius = 5.0
        tapstart.clipsToBounds = true

        let swipeRightRec = UISwipeGestureRecognizer()
        let swipeLeftRec = UISwipeGestureRecognizer()
        let swipeUpRec = UISwipeGestureRecognizer()
        let swipeDownRec = UISwipeGestureRecognizer()
        

        swipeDownRec.addTarget(self, action: #selector(self.swipeBack) )
        swipeDownRec.direction = .down
        self.view!.addGestureRecognizer(swipeDownRec)
        
        
        authorimage.layer.cornerRadius = authorimage.frame.size.width / 2
        authorimage.clipsToBounds = true
        
        var imageURLString = selectedauthorimage
        
        var imageUrl = URL(string: imageURLString)
        
        
        authorimage.kf.setImage(with: imageUrl)
        
        imageURLString = selectedbackground
          
        imageUrl = URL(string: imageURLString)
          
          blurredimage.kf.setImage(with: imageUrl)
        
        backimagel.kf.setImage(with: imageUrl)

        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = blurredimage.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurredimage.addSubview(blurEffectView)
        
        authorlabel.text = selectedauthorname
        titlelabel.text = selectedtitle
        professionlabel.text = selectedprofession
        descriptionlabel.text = "\(selecteddescription) We hope this writing session helps you feel better 😊"
 

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func tapBack2(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)

    }
    @objc func swipeBack() {
        
        self.dismiss(animated: true, completion: nil)

    }
    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
