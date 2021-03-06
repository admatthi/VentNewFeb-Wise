//
//  HomeViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 10/31/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase
import AudioToolbox
import AVFoundation

var time = String()

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

   var counter = 0
           //
           var books: [Book] = [] {
               didSet {

                   self.titleTableView.reloadData()

               }
           }


 

           @IBOutlet weak var titleTableView: UITableView!

           var swipecounter = Int()

           let swipeRightRec = UISwipeGestureRecognizer()
           let swipeLeftRec = UISwipeGestureRecognizer()
           let swipeUpRec = UISwipeGestureRecognizer()
           let swipeDownRec = UISwipeGestureRecognizer()

      
   

           var intdayofweek = Int()


           @IBOutlet var darklabel: UILabel!

    

     


           var mycolors = [UIColor]()

           override func viewDidLoad() {
               super.viewDidLoad()

               ref = Database.database().reference()
            
            queryforinfo()
            
               selectedgenre = "Chill"


               titleTableView.reloadData()
            
    
            
                  let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH"
            time = dateFormatter.string(from: NSDate() as Date)

               //        addstaticbooks()



               //        dayofmonth = "15"


             
            queryforids { () -> Void in
                
            }

               counter = 0


                
               // Do any additional setup after loading the view.
           }


       
       var genreindex = Int()
           var text = String()


         func queryforids(completed: @escaping (() -> Void) ) {


               var functioncounter = 0

    

               ref?.child("AllBooks1").child(selectedgenre).observeSingleEvent(of: .value, with: { (snapshot) in

                   var value = snapshot.value as? NSDictionary

                   print (value)

                   if let snapDict = snapshot.value as? [String: AnyObject] {

                       let genre = Genre(withJSON: snapDict)

                       if let newbooks = genre.books {

                           self.books = newbooks
                        
                            
                        if Int(time) ?? 11 > 12 {
                            
                            self.books = self.books.sorted(by: { $1.name ?? "1"  > $0.name ?? "2" })

                        } else {
                            
                            self.books = self.books.sorted(by: { $0.name ?? "1"  > $1.name ?? "2" })

                        }


                       }

       //                                for each in snapDict {
       //
       //                                    functioncounter += 1
       //
       //                                    let ids = each.key
       //
       //                                    seemoreids.append(ids)
       //
       //
       //                                    if functioncounter == snapDict.count {
       //
       //                                        self.updateaudiostructure()
       //
       //                                    }
       //                                }
                   }

               })
           }
           

           var dayofmonth = String()

           func addstaticbooks() {

               var counter2 = 0

               while counter2 < 25 {

                ref?.child("AllBooks1").child(selectedgenre).childByAutoId().updateChildValues(["Name": "x", "Image" : "x", "Author" : "x"])


                   counter2 += 1

               }

           }

           override func didReceiveMemoryWarning() {
               super.didReceiveMemoryWarning()
               // Dispose of any resources that can be recreated.
           }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        refer = "On Tap Daily"
                
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
            
            let book = self.book(atIndexPath: indexPath)
            
            headlines.removeAll()
            
            bookindex = indexPath.row
            selectedauthorname = book?.author ?? ""
            selectedtitle = book?.name ?? ""
            selectedurl = book?.audioURL ?? ""
            selectedbookid = book?.bookID ?? ""
            randomString = NSUUID().uuidString

            selectedgenre = book?.genre ?? ""
            selectedamazonurl = book?.amazonURL ?? ""
            selecteddescription = book?.description ?? ""
            selectedduration = book?.duration ?? 15
            selectedheadline = book?.headline1 ?? ""
            selectedprofession = book?.profession ?? ""
            selectedauthorimage = book?.authorImage ?? ""
            selectedbackground = book?.imageURL ?? ""
            
            headlines.append(book?.headline1 ?? "x")
            headlines.append(book?.headline2 ?? "x")
            headlines.append(book?.headline3 ?? "x")
            headlines.append(book?.headline4 ?? "x")
            headlines.append(book?.headline5 ?? "x")
            headlines.append(book?.headline6 ?? "x")
            headlines.append(book?.headline7 ?? "x")
            headlines.append(book?.headline8 ?? "x")
            
            headlines = headlines.filter{$0 != "x"}
            
            
            let alert = UIAlertController(title: "What would you like to do?", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Read", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            alert.addAction(UIAlertAction(title: "Listen", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                    self.performSegue(withIdentifier: "HomeToListen", sender: self)
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            
            
            self.performSegue(withIdentifier: "DailyToRead", sender: self)
      
            
    }

    @IBAction func tapDiscount(_ sender: Any) {
        
        let alert = UIAlertController(title: "Please enter your discount code", message: "", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: configurationTextField)

                  alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { action in
                      switch action.style{
                      case .default:
                          print("default")
                        
                        let textField = alert.textFields![0] // Force unwrapping because we know it exists.
                        
                        if textField.text != "" {
                            
                            if actualdiscount == textField.text! {
                                
                                didpurchase = true
                                
                                ref?.child("Users").child(uid).updateChildValues(["Purchased" : "True"])
                                
                            }
                            
                        }
                          
                          
                      case .cancel:
                          print("cancel")
                          
                      case .destructive:
                          print("destructive")
                          
                          
                      }}))
        
        self.present(alert, animated: true, completion: nil)

        
    }
    
    func configurationTextField(textField: UITextField!){
           textField?.placeholder = "Promo Code"
           
           
           
           
       }
    
    override func viewDidAppear(_ animated: Bool) {
        
        textone = ""
            let dateFormatter = DateFormatter()
                 dateFormatter.dateFormat = "HH"
                 time = dateFormatter.string(from: NSDate() as Date)
        
        titleTableView.reloadData()
          
      }

           func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
            return books.count

            }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        let book = self.book(atIndexPath: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Home", for: indexPath) as! HomeTableViewCell
          //            if book?.bookID == "Title" {
          //
          //                return cell
          //
          //            } else {
          
          
          

   
          let date = Date()
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "MMM d"
          let result = dateFormatter.string(from: date)
          
          dateformat = result
          cell.datelabel.text = result
          
          let name = book?.name
        
        cell.titlelabel.text = name

          
        cell.backimage.alpha = 0.8

          
          
     
               if let imageURLString = book?.imageURL, let imageUrl = URL(string: imageURLString) {
              
              cell.titleImage.kf.setImage(with: imageUrl)
                
        }
          
          
          var randomint = Int.random(in: 100..<1000)
          
          
//          cell.titleImage.layer.cornerRadius = cell.titleImage.frame.size.width/2
//          cell.titleImage.clipsToBounds = true
//          cell.titleImage.alpha = 1
          
              
          
          cell.layer.cornerRadius = 15.0
          cell.clipsToBounds = true
          
    
          
          
          
          
          
          return cell
          
          
          
      }
    
    func queryforinfo() {
                
        ref?.child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            if let purchased = value?["Purchased"] as? String {
                
                if purchased == "True" {
                    
                    didpurchase = true
                    
                } else {
                                 
                    didpurchase = false
                    self.performSegue(withIdentifier: "HomeToSale2", sender: self)
                    
                }
                
            } else {
                
                didpurchase = false
              self.performSegue(withIdentifier: "HomeToSale2", sender: self)
            }
     
        })
        
    }

           var selectedindex = Int()

           

           @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
           /*
            // MARK: - Navigation

            // In a storyboard-based application, you will often want to do a little preparation before navigation
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
            }
            */
        
    @IBAction func tapShowDiscount(_ sender: Any) {
        
        
    }

    
    
           

       

       }

var didpurchase = Bool()
       // MARK: - Helpers
       extension HomeViewController {
           func book(atIndex index: Int) -> Book? {
               if index > books.count - 1 {
                   return nil
               }

               return books[index]
           }

           func book(atIndexPath indexPath: IndexPath) -> Book? {
               return self.book(atIndex: indexPath.row)
           }
       }


var slimeybool = Bool()
