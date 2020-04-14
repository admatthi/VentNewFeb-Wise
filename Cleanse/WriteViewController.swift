//
//  WriteViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 4/12/20.
//  Copyright © 2020 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tapstartsave: UIButton!
    @IBAction func tapStartSave(_ sender: Any) {
        
 

    }
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var timerlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        timerlabel.text = "300s"
        
        textView.delegate = self

        addDoneButtonOnKeyboard()
        // Do any additional setup after loading the view.
    }
    
    @objc func update() {
        if(count > 0) {
            count -= 1
            
            timerlabel.text = "\(String(count))s"
        }
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
        
        
        if textView.text == "Tap to start timer..." {
            textView.text = ""
            textView.textColor = UIColor.black
            count = 300
             
             timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WriteViewController.update), userInfo: nil, repeats: true)
        }
    }
    
    var timer = Timer()
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        timer.invalidate()
        if textView.text.isEmpty {
            textView.text = "Tap to start timer..."
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
