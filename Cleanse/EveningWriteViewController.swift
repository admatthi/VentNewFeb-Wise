//
//  EveningWriteViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 4/14/20.
//  Copyright © 2020 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit

class EveningWriteViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var backimage: UIImageView!
    
    @IBOutlet weak var tapstartsave: UIButton!
        @IBAction func tapStartSave(_ sender: Any) {
        
        
              if count == 0 {
                          
                          ref?.child("Users").child(uid).childByAutoId().updateChildValues(["Text" : "\(textView.text!)"])
                timerlabel.text = "2:00"
                count = 120
                textView.text = ""
                view.endEditing(true)
                tapsave.alpha = 0
                
              } else {
                  
                  
              }

        }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBOutlet weak var tapsave: UIButton!
    @IBOutlet weak var textView: UITextView!
        @IBOutlet weak var timerlabel: UILabel!
        override func viewDidLoad() {
            super.viewDidLoad()

            timerlabel.text = "2:00"

            textView.delegate = self

            addDoneButtonOnKeyboard()
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
            
            view.addGestureRecognizer(tap)


            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = backimage.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            backimage.addSubview(blurEffectView)
            count = 120

            
            
            // Do any additional setup after loading the view.
        }
        
        @objc func update() {
            if count > 0 {
                count -= 1
                
                timerlabel.text = "\(String(count))s"
                timerlabel.text = timeString(time: TimeInterval(count))
            }
            
            if count == 0 {
                    
                    tapsave.alpha = 1
                }
        }
        
        let timeInterval:TimeInterval = 1
        let timerEnd:TimeInterval = 0.0
        var timeCount:TimeInterval = 7200.0
        
        func timeString(time:TimeInterval) -> String {
            
        let hours = Int(time) / 3600
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            return String(format:"%2i:%02i", minutes, seconds)
            
        }
        
        func addDoneButtonOnKeyboard()
        {
            var doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
            doneToolbar.barStyle = UIBarStyle.blackTranslucent

            var flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            var done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(WriteViewController.doneButtonAction))

            var items = NSMutableArray()
            
            items.add(done)

            doneToolbar.items = items as! [UIBarButtonItem]
            doneToolbar.sizeToFit()

            textView.inputAccessoryView = doneToolbar

        }
    
   

        @objc func doneButtonAction()
        {
            textView.resignFirstResponder()
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WriteViewController.update), userInfo: nil, repeats: true)

            if textView.text == "Tap to start writing session..." {
                textView.text = ""
                textView.textColor = UIColor.white
                 
            }
        }
        
        var timer = Timer()
        
        func textViewDidEndEditing(_ textView: UITextView) {
            
            timer.invalidate()
            if textView.text.isEmpty {
                textView.text = "Tap to start writing session..."
                textView.textColor = UIColor.lightGray
            }
        }
        
        var count = Int()

        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */

    }
