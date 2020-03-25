//
//  ConsumeViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 3/16/20.
//  Copyright © 2020 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit

class ConsumeViewController: UIViewController {

    var counter = Int()
    
    @IBOutlet weak var backimage: UIImageView!
    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    var arrayCount = Int()
    
    func showproperquote() {
            
            if counter == 0 {
                
                self.progressView.setProgress(0.0, animated:false)

            } else {
                
                let progress = (Float(counter)/Float(arrayCount-1))
                self.progressView.setProgress(Float(progress), animated:true)
            }
            
            if counter < headlines.count {
                
            
                headlinelabel.text = headlines[counter]
   

            }
        }
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var headlinelabel: UILabel!
    
    @IBAction func tapNext(_ sender: Any) {
        
        nextcount()

    }
    @IBOutlet weak var authorlabel: UILabel!
    
    @IBAction func tapPrevious(_ sender: Any) {
        
        
        
        if counter > 0 {
                 
                 lastcount()

             }
    }
    
    func lastcount() {
        
        
        
        
        
        if counter == 0 {
            
            
        } else {
            
            counter -= 1
            showproperquote()
            
            
        }

    }
    
    func nextcount() {
        

        if counter > headlines.count-2 {
            
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
         
        
            self.dismiss(animated: true, completion: nil)

            
        } else {

            counter += 1

            showproperquote()
            
           
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        authorlabel.text = "\(selectedtitle) on \(selectedgenre.replacingOccurrences(of: " ", with: ""))"
//        
        counter = 0 
        
        arrayCount = headlines.count
        
        let imageURLString = selectedbackground
        
        headlinelabel.text = selectedtitle
        authorlabel.text = selectedauthorname
            
            if let imageUrl = URL(string: imageURLString) {
                
                backimage.kf.setImage(with: imageUrl)

            }
            
        self.progressView.setProgress(0.0, animated:false)

        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = backimage.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        backimage.addSubview(blurEffectView)
        
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

}
