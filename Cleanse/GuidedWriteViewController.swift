//
//  GuidedWriteViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 4/16/20.
//  Copyright © 2020 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase
import AudioToolbox
import AVFoundation

class GuidedWriteViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {

    @IBOutlet weak var tapstartsave: UIButton!
        @IBAction func tapStartSave(_ sender: Any) {
            
     

        }
        @IBAction func tapTimer(_ sender: Any) {
            
            view.endEditing(true)

            pickerView.alpha = 1
            
        }
        @IBOutlet weak var taptimer: UIButton!
        @IBOutlet weak var pickerView: UIPickerView!
    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var tapsave: UIButton!
        @IBAction func tapSave(_ sender: Any) {
            taptimer.alpha = 1
            
            if count == 0 {
                        
                let date = Date()
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "MMM d"
                     var result = dateFormatter.string(from: date)
                
                ref?.child("Users").child(uid).childByAutoId().updateChildValues(["Text" : "\(textView.text!)", "Name" : headlinelabel.text!, "Date" : result])
                
                taptimer.setTitle(self.timeString(time: TimeInterval(desiredtimeinseconds)), for: .normal)

                          count = desiredtimeinseconds
                          textView.text = "Tap to start writing session"
                            textView.textColor = UIColor.lightGray

                          view.endEditing(true)
                          tapsave.alpha = 0
                
                self.dismiss(animated: true, completion: nil)
            } else {
                
                
            }
        }
    
    var arrayCount = Int()
    
    @IBOutlet weak var headlinelabel: UILabel!
    
        @IBOutlet weak var backimage: UIImageView!
        @IBOutlet weak var textView: UITextView!
        @IBOutlet weak var timerlabel: UILabel!
        override func viewDidLoad() {
            super.viewDidLoad()
            ref = Database.database().reference()
            timeintervals.removeAll()

    //        taptimer = UIButton(type: .custom) as UIButton
            
            timeintervals.append("1m")
             timeintervals.append("2m")
             timeintervals.append("5m")
             timeintervals.append("10m")
             timeintervals.append("15m")
             timeintervals.append("30m")
            
            queryforinfo()
            
            pickerView.delegate = self

            
            textView.delegate = self
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")

            view.addGestureRecognizer(tap)

            addDoneButtonOnKeyboard()
            
            counter = 0
            
            arrayCount = headlines.count
            
            ref = Database.database().reference()
            
                        
            
            headlinelabel.text = headlines[counter]
            
            
       
            
            pickerView.alpha = 0
            
            pickerView.reloadAllComponents()
            // Do any additional setup after loading the view.
        }
    
    func showpropersummaries() {
        
        if counter == 0 {
            
            
        } else {
            
        }
        
        if counter < headlines.count {
            
            randomstring = UUID().uuidString
            
            
            headlinelabel.text = headlines[counter].capitalizingFirstLetter()
            
            
            print(counter)
            
        }
    }
    
    var randomstring = String()
        
        var timeintervals = [String]()
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return timeintervals.count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
                
            return timeintervals[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
            let titleData = timeintervals[row]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])

            return myTitle
        }
        
      

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
            var newtimeinterval = timeintervals[row].replacingOccurrences(of: "m", with: "")
            var intnewtimeinterval = 60 * (Int(newtimeinterval) ?? 120)
            desiredtimeinseconds = intnewtimeinterval
            count = desiredtimeinseconds
            
            ref?.child("Users").child(uid).updateChildValues(["Time Interval" : desiredtimeinseconds])
            
            taptimer.setTitle(self.timeString(time: TimeInterval(desiredtimeinseconds)), for: .normal)
            
            pickerView.alpha = 0
            


        }
        
        func queryforinfo() {
            
            ref?.child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                let value = snapshot.value as? NSDictionary
                
                if let timeinterval = value?["Time Interval"] as? Int {
                    
                    desiredtimeinseconds = timeinterval
                    self.taptimer.setTitle(self.timeString(time: TimeInterval(desiredtimeinseconds)), for: .normal)
                    self.count = desiredtimeinseconds
                    
                } else {
                    
                    desiredtimeinseconds = 120
                    self.taptimer.setTitle(self.timeString(time: TimeInterval(desiredtimeinseconds)), for: .normal)

                }
                
                if let purchased = value?["Purchased"] as? String {
                    
                    if purchased == "True" {
                        
                        didpurchase = true
                        
                    } else {
                        
                        didpurchase = false
    //                    self.performSegue(withIdentifier: "DiscoverToSale2", sender: self)
                        
                    }
                    
                } else {
                    
                    didpurchase = false
    //                self.performSegue(withIdentifier: "DiscoverToSale2", sender: self)
                }
                
            })
            
        }
        
      
        
        @objc func update() {
            
            
            
            if(count > 0) {
                count -= 1
                
                                
                
                UIView.performWithoutAnimation {
                    taptimer.setTitle(self.timeString(time: TimeInterval(count)), for: .normal)
                    taptimer.layoutIfNeeded()
                }

            }
            
            if count == 0 {
                
                taptimer.alpha = 0
                tapsave.alpha = 1
            }
        }
        
        @objc func dismissKeyboard() {
             //Causes the view (or one of its embedded text fields) to resign the first responder status.
             view.endEditing(true)
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
                textView.textColor = UIColor.black
                 
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
