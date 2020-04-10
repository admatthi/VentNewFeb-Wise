//
//  TextViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 10/27/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase
import FBSDKCoreKit

var selectedheadline = String()
var dateformat = String()
var randomString = String()


class TextViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var background2: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bookcover: UIImageView!
    @IBOutlet weak var authorlabel: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    
    
    func logFavoriteTapped(referrer : String) {
        AppEvents.logEvent(AppEvents.Name(rawValue: "favorite tapped"), parameters: ["referrer" : referrer, "quoteid" : id])
    }
    
    func logGenreViewed(referrer : String) {
        AppEvents.logEvent(AppEvents.Name(rawValue: "genre viewed"), parameters: ["referrer" : referrer, "genre" : selectedgenre])
    }
    
    func logTapShare(referrer : String) {
        AppEvents.logEvent(AppEvents.Name(rawValue: "share tapped"), parameters: ["referrer" : referrer, "quoteid" : id])
    }
    
    func logTapDownvote(referrer : String) {
        AppEvents.logEvent(AppEvents.Name(rawValue: "downvote tapped"), parameters: ["referrer" : referrer, "quoteid" : id])
    }
    
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textView.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        textView.resignFirstResponder()
    }
    
    @IBAction func tapBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    var arrayCount = Int()
    
    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var text: UILabel!
    
    func nextcount() {
        
        
        if counter > headlines.count-2 {
            
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
            
            
            
            self.dismiss(animated: true, completion: nil)
            
        } else {
            
            counter += 1
            
            
            titlelabel.slideInFromRight()
            authorlabel.slideInFromRight()
            tapshare.slideInFromRight()
            taplike.slideInFromRight()
            tapdownvote.slideInFromRight()
            showpropersummaries()
            //            textView.slideInFromRight()
            //            text.slideInFromRight()
        }
        
    }
    //
    //    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    //         if(text == "\n") {
    //             textView.resignFirstResponder()
    //             return false
    //         }
    //         return true
    //     }
    
    /* Older versions of Swift */
    //     func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    //         if(text == "\n") {
    //             textView.resignFirstResponder()
    //             return false
    //         }
    //         return true
    //     }
    
    @IBAction func tapDismiss(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var authorftile: UILabel!
    @IBOutlet weak var titleoftile: UILabel!
    
    
    @IBAction func tapDelete(_ sender: Any) {
        
        ref?.child("AllBooks1").child(selectedamazonurl).child(selectedbookid).updateChildValues(["Headline\(counter+1)" : "x"])
        
        nextcount()
    }
    
    @IBOutlet weak var backimage: UIImageView!
    @IBOutlet weak var whiteline: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter = 0
        arrayCount = headlines.count
        
        ref = Database.database().reference()
        titlelabel.heightAnchor
        
//                ref?.child("AllBooks1").child(selectedamazonurl).child(selectedbookid).updateChildValues(["Profession" : "\(arrayCount) quotes"])
        
        randomstring = UUID().uuidString
        
        
        titlelabel.text = headlines[counter]
        
        
        let imageURLString = selectedbackground
        
        let  imageUrl = URL(string: imageURLString)
        
        backimage.kf.setImage(with: imageUrl)
        authorlabel.text = "- \(selectedgenre)"
        
        let swipeRightRec = UISwipeGestureRecognizer()
        let swipeLeftRec = UISwipeGestureRecognizer()
        let swipeUpRec = UISwipeGestureRecognizer()
        let swipeDownRec = UISwipeGestureRecognizer()
        
        swipeRightRec.addTarget(self, action: #selector(self.swipeR) )
        swipeRightRec.direction = .right
        self.view!.addGestureRecognizer(swipeRightRec)
        
        
        swipeLeftRec.addTarget(self, action: #selector(self.swipeL) )
        swipeLeftRec.direction = .left
        self.view!.addGestureRecognizer(swipeLeftRec)
        
        swipeDownRec.addTarget(self, action: #selector(self.swipeD) )
        swipeDownRec.direction = .down
        self.view!.addGestureRecognizer(swipeDownRec)
        
        //
        //                 tapsave.alpha = 0.5
        //                 tapsave.isUserInteractionEnabled = false
        //            characterslabel.alpha = 1
        //             } else {
        //
        //                 tapsave.alpha = 1
        //                 tapsave.isUserInteractionEnabled = true
        //                characterslabel.alpha = 0
        //             }
        //
        
        // Do any additional setup after loading the view.
    }
    
    open func takeScreenshot(_ shouldSave: Bool = true) -> UIImage? {
        
        var screenshotImage :UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = screenshotImage, shouldSave {
            
            screenshot = image
            
        }
        
        return screenshotImage
    }
    
    var screenshot = UIImage()
    
    @IBAction func tapShare(_ sender: Any) {
        
        logTapShare(referrer: referrer)
        
        takeScreenshot()
        let text = ""
        
        var image = self.screenshot
        //
        //                             let myWebsite = NSURL(string: "https://motivationapp.page.link/share")
        
        let shareAll : Array = [image] as [Any]
        
        
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo, UIActivity.ActivityType.saveToCameraRoll, UIActivity.ActivityType.assignToContact]
        
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    @IBOutlet weak var tapdownvote: UIButton!
    @IBOutlet weak var tapsavetop: UIButton!
    @IBOutlet weak var tapshare: UIButton!
    @IBAction func tapDownvote(_ sender: Any) {
        
        logTapDownvote(referrer: referrer)
        nextcount()
        
    }
    @IBOutlet weak var taplike: UIButton!
    
    var id = String()
    var bookmarktapped = Bool()
    
    var randomstring = String()
    
    @IBAction func tapLike(_ sender: Any) {
        
        
        let formatter = DateFormatter()
                  // initially set the format based on your datepicker date / server String
                  formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                  
                  let myString = formatter.string(from: Date()) // string purpose I add here
                  // convert your string to date
                  let yourDate = formatter.date(from: myString)
                  //then again set the date format whhich type of output you need
                  formatter.dateFormat = "dd-MMM-yyyy"
                  // again convert your date to string
                  let myStringafd = formatter.string(from: yourDate!)
                  
//                  ref?.child("AllBooks1").child(selectedamazonurl).child(selectedbookid).updateChildValues(["Date" : myString])
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        if bookmarktapped {
            
            ref?.child("Users").child(uid).child(randomstring).removeValue()
            
            taplike.setBackgroundImage(UIImage(named: "LightBookMark"), for: .normal)
            
            bookmarktapped = false
            
        } else {
            
            taplike.setBackgroundImage(UIImage(named: "DarkBookMark"), for: .normal)
            
            var trimmedtext = String()
            logFavoriteTapped(referrer: referrer)
            
            trimmedtext = titlelabel.text ?? "x"
            
            var authorget = selectedauthorname
            ref?.child("Users").child(uid).child(randomstring).updateChildValues(["Name" : trimmedtext, "Author" : authorget, "Image" : selectedbackground])
            
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date / server String
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let myString = formatter.string(from: Date()) // string purpose I add here
            // convert your string to date
            let yourDate = formatter.date(from: myString)
            //then again set the date format whhich type of output you need
            formatter.dateFormat = "dd-MMM-yyyy"
            // again convert your date to string
            let myStringafd = formatter.string(from: yourDate!)
            
            //                ref?.child("AllBooks1").child(selectedgenre).child(id).updateChildValues(["Date" : myString])
            
            bookmarktapped = true
            
        }
        
    }
    
    
    
    func lastcount() {
        
        if counter == 0 {
            
            self.dismiss(animated: true, completion: nil)
            
        } else {
            
            counter -= 1
            titlelabel.slideInFromLeft()
            authorlabel.slideInFromLeft()
            taplike.slideInFromLeft()
            tapshare.slideInFromLeft()
            tapdownvote.slideInFromLeft()
            showpropersummaries()
            //
            //             textView.slideInFromLeft()
            //             text.slideInFromLeft()
            
        }
        
        
    }
    
    @objc func swipeR() {
        
        bookmarktapped = false
        
        taplike.setBackgroundImage(UIImage(named: "LightBookMark"), for: .normal)
        
        lastcount()
        
        
        
    }
    
    @objc func swipeD() {
        
        
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
    
    
    @objc func swipeL() {
        
        bookmarktapped = false
        
        taplike.setBackgroundImage(UIImage(named: "LightBookMark"), for: .normal)
        
        nextcount()
        
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        
    }
    
    func showpropersummaries() {
        
        if counter == 0 {
            
            
        } else {
            
        }
        
        if counter < headlines.count {
            
            randomstring = UUID().uuidString
            
            
            titlelabel.text = headlines[counter].capitalizingFirstLetter()
            
            
            print(counter)
            
        }
    }
    
    @IBOutlet weak var characterslabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        whiteline.alpha = 0
        textView.textColor = .white
    }
    
    var newText = String()
    
    func textViewDidChange(_ textView: UITextView) {
        
        //        newText = textView.text
        //
        //        let myint = 240-newText.count
        //
        //        characterslabel.text = "\(myint)"
        //
        //        if newText.count < 240 {
        //
        //            tapsave.alpha = 0.5
        //            tapsave.isUserInteractionEnabled = false
        //            characterslabel.alpha = 1
        //        } else {
        //
        //            tapsave.alpha = 1
        //            tapsave.isUserInteractionEnabled = true
        //            characterslabel.alpha = 0
        //        }
    }
    
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(TextViewController.dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.textView.inputAccessoryView = keyboardToolbar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBOutlet weak var tapsave: UIButton!
    @IBAction func tapContinue(_ sender: Any) {
        
        if textView.text != "" {
            
            if headlines.count == 1 {
                
                ref?.child("Entries").child(uid).child(selectedbookid).removeValue()
                
                ref?.child("Entries").child(uid).childByAutoId().updateChildValues(["Author" : selectedauthorname, "Name" : selectedtitle, "Headline1" : headlines[0], "Author Image" : selectedauthorimage, "Image" : selectedbackground, "Text\(counter)" : textView.text!, "Date" : dateformat])
                
            }
            
            if headlines.count == 2 {
                
                ref?.child("Entries").child(uid).child(selectedbookid).removeValue()
                
                ref?.child("Entries").child(uid).childByAutoId().updateChildValues(["Author" : selectedauthorname, "Name" : selectedtitle, "Headline1" : headlines[0], "Headline2" : headlines[1], "Author Image" : selectedauthorimage, "Image" : selectedbackground, "Text\(counter)" : textView.text!, "Date" : dateformat])
                
            }
            
            
            if headlines.count == 3 {
                
                
                
                ref?.child("Entries").child(uid).child(randomString).updateChildValues(["Author" : selectedauthorname, "Name" : selectedtitle, "Headline1" : headlines[0], "Headline2" : headlines[1], "Headline3" : headlines[2], "Author Image" : selectedauthorimage, "Image" : selectedbackground, "Text\(counter)" : textView.text!, "Date" : dateformat])
                
            }
            
            if headlines.count == 4 {
                
                
                
                ref?.child("Entries").child(uid).child(randomString).updateChildValues(["Author" : selectedauthorname, "Name" : selectedtitle, "Headline1" : headlines[0], "Headline2" : headlines[1], "Headline3" : headlines[2],"Headline4" : headlines[3], "Author Image" : selectedauthorimage, "Image" : selectedbackground, "Text\(counter)" : textView.text!, "Date" : dateformat])
                
            }
            
            if headlines.count == 5 {
                
                
                
                ref?.child("Entries").child(uid).child(randomString).updateChildValues(["Author" : selectedauthorname, "Name" : selectedtitle, "Headline1" : headlines[0], "Headline2" : headlines[1], "Headline3" : headlines[2],"Headline4" : headlines[3],"Headline5" : headlines[4], "Author Image" : selectedauthorimage, "Image" : selectedbackground, "Text\(counter)" : textView.text!, "Date" : dateformat])
                
            }
            
            if headlines.count == 6 {
                
                
                
                ref?.child("Entries").child(uid).child(randomString).updateChildValues(["Author" : selectedauthorname, "Name" : selectedtitle, "Headline1" : headlines[0], "Headline2" : headlines[1], "Headline3" : headlines[2],"Headline4" : headlines[3],"Headline5" : headlines[4],"Headline6" : headlines[5], "Author Image" : selectedauthorimage, "Image" : selectedbackground, "Text\(counter)" : textView.text!, "Date" : dateformat])
                
            }
            
            if headlines.count == 7 {
                
                
                
                ref?.child("Entries").child(uid).child(randomString).updateChildValues(["Author" : selectedauthorname, "Name" : selectedtitle, "Headline1" : headlines[0], "Headline2" : headlines[1], "Headline3" : headlines[2],"Headline4" : headlines[3],"Headline5" : headlines[4],"Headline6" : headlines[5],"Headline7" : headlines[6], "Author Image" : selectedauthorimage, "Image" : selectedbackground, "Text\(counter)" : textView.text!, "Date" : dateformat])
                
            }
            
            if headlines.count == 8 {
                
                
                
                ref?.child("Entries").child(uid).child(randomString).updateChildValues(["Author" : selectedauthorname, "Name" : selectedtitle, "Headline1" : headlines[0], "Headline2" : headlines[1], "Headline3" : headlines[2],"Headline4" : headlines[3],"Headline5" : headlines[4],"Headline6" : headlines[5],"Headline7" : headlines[6],"Headline8" : headlines[7], "Author Image" : selectedauthorimage, "Image" : selectedbackground, "Text\(counter)" : textView.text!, "Date" : dateformat])
                
            }
            
            nextcount()
            
        } else {
            
            nextcount()
            
        }
        
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = " "
            textView.textColor = UIColor.lightGray
            whiteline.alpha = 1
        }
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

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
