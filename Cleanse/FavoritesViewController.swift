//
//  FavoritesViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 1/26/20.
//  Copyright © 2020 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Firebase

class FavoritesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var genres = [String]()
    @IBOutlet weak var backimage: UIImageView!
        var books: [Book] = [] {
                  didSet {

                    bookmarktapped = true
                    let book = self.book(atIndex: 0)
                                               //            if book?.bookID == "Title" {
                                               //
                                               //                return cell
                                               //
                                               //            } else {
                                               
                                               
                                               
                                      let name = book?.name
                                      let author = book?.author
                    titleCollectionView.reloadData()
    //                  self.titleCollectionView.reloadData()

                  }
              }
          var genreindex = Int()

          func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
                switch collectionView {
                    case self.genreCollectionView:
                        return genres.count
                    case self.titleCollectionView:
                        return books.count
                    default:
                        return 0
                    }
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

                refer = "On Tap Discover"

                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
                self.view.endEditing(true)

                if collectionView.tag == 1 {
                    
                    if didpurchase {

                    selectedindex = indexPath.row

                    genreCollectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)

                    collectionView.alpha = 0

                    selectedgenre = genres[indexPath.row]


                    genreindex = indexPath.row

                    queryforids { () -> Void in

                    }

        //            titleCollectionView.scrollToItem(at: indexPath, at: .top, animated: false)
                    

                    genreCollectionView.reloadData()
                        
                    } else {
                        
                        self.performSegue(withIdentifier: "FavoritesToRead", sender: self)

                    }

                } else {

                    let book = self.book(atIndexPath: indexPath)

                    
                    headlines.removeAll()
                    
                    bookindex = indexPath.row
                    selectedauthorname = book?.author ?? ""
                    selectedtitle = book?.name ?? ""
                    selectedurl = book?.audioURL ?? ""
                    selectedbookid = book?.bookID ?? ""
                    selectedgenre = book?.genre ?? ""
                    selectedamazonurl = book?.amazonURL ?? ""
                    selecteddescription = book?.description ?? ""
                    selectedduration = book?.duration ?? 15
                    selectedheadline = book?.name ?? ""
                    selectedprofession = book?.profession ?? ""
                    selectedauthorimage = book?.authorImage ?? ""
                    selectedbackground = book?.imageURL ?? ""

                    
                        
                    headlines.append(book?.name ?? "x")
                    headlines.append(book?.headline2 ?? "x")
                    headlines.append(book?.headline3 ?? "x")
                    headlines.append(book?.headline4 ?? "x")
                    headlines.append(book?.headline5 ?? "x")
                    headlines.append(book?.headline6 ?? "x")
                    headlines.append(book?.headline7 ?? "x")
                    headlines.append(book?.headline8 ?? "x")
                    headlines.append(book?.headline9 ?? "x")
                    headlines.append(book?.headline10 ?? "x")
                    headlines.append(book?.headline11 ?? "x")
                    headlines.append(book?.headline12 ?? "x")
                    headlines.append(book?.headline13 ?? "x")
                    headlines.append(book?.headline14 ?? "x")
                    headlines.append(book?.headline15 ?? "x")


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
                    
                    if indexPath.row > 4 {
                                 
                                 if didpurchase {
                                     
                                                        self.performSegue(withIdentifier: "FavoritesToRead", sender: self)

                                     
                                 } else {
                                 
                               
                          self.performSegue(withIdentifier: "FavoritesToRead", sender: self)
                                 
                                 }
                    } else {
                        
                                     self.performSegue(withIdentifier: "FavoritesToRead", sender: self)
                    }
                             
                    
                
                    

                 
                }


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
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            switch collectionView {
            // Genre collection
            case self.genreCollectionView:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Categories", for: indexPath) as! GenreCollectionViewCell
                
    //            collectionView.alpha = 1
                cell.titlelabel.text = genres[indexPath.row]
                //            cell.titlelabel.sizeToFit()
                
                cell.selectedimage.layer.cornerRadius = 10.0
                cell.selectedimage.layer.masksToBounds = true
                
                
                
                
                genreCollectionView.alpha = 1
                
                if selectedindex == 0 {
                    
                    if indexPath.row == 0 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                }
                
                if selectedindex == 1 {
                    
                    if indexPath.row == 1 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                if selectedindex == 2 {
                    
                    if indexPath.row == 2 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                if selectedindex == 3 {
                    
                    if indexPath.row == 3 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                if selectedindex == 4 {
                    
                    if indexPath.row == 4 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                }
                
                if selectedindex == 5 {
                    
                    if indexPath.row == 5 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                if selectedindex == 6 {
                    
                    if indexPath.row == 6 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                if selectedindex == 7 {
                    
                    if indexPath.row == 7 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                if selectedindex == 8 {
                    
                    if indexPath.row == 8 {
                        
                        cell.titlelabel.alpha = 1
                        cell.selectedimage.alpha = 1
                        
                    } else {
                        
                        cell.titlelabel.alpha = 0.25
                        cell.selectedimage.alpha = 0
                        
                    }
                    
                }
                
                
                if selectedindex == 1000 {
                    
                    cell.titlelabel.alpha = 0.25
                    cell.selectedimage.alpha = 0
                }
                
                return cell
                
            case self.titleCollectionView:
                let book = self.book(atIndexPath: indexPath)
                titleCollectionView.alpha = 1
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Books", for: indexPath) as! TitleCollectionViewCell
                //
                //            if book?.bookID == "Title" {
                //
                //                return cell
                //
                //            } else {
                
                
                
                let name = book?.name
                
//                cell.genrelabel.text = "\(book!.author!)"
                
                if (name?.contains(":"))! {
                    
                    var namestring = name?.components(separatedBy: ":")
                    
                    cell.titlelabel.text = namestring![0]
                    
                } else {
                    
                    cell.titlelabel.text = name
                    
                }
                
                cell.titleImage.layer.shadowColor = UIColor.black.cgColor
                cell.titleImage.layer.shadowOffset = CGSize(width: 1, height: 1)
                cell.titleImage.layer.shadowOpacity = 1
                cell.titleImage.layer.shadowRadius = 1.0
                cell.titleImage.layer.cornerRadius = 10.0
                cell.titleImage.clipsToBounds = true
    //            cell.titleback.layer.cornerRadius = 10.0
    //                       cell.titleback.clipsToBounds = true
                
                cell.layer.cornerRadius = 10.0
                cell.layer.cornerRadius = 10.0

                
                //                cell.tapup.tag = indexPath.row
                //
                //                cell.tapup.addTarget(self, action: #selector(DiscoverViewController.tapWishlist), for: .touchUpInside)
                
                
              
                if let imageURLString = book?.imageURL, let imageUrl = URL(string: imageURLString) {
                    
                                                cell.titleImage.kf.setImage(with: imageUrl)
                    
                    
    //                cell.titleback.kf.setImage(with: imageUrl)

                    
    //                let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    //                                    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    //                          blurEffectView.frame = cell.titleback.bounds
    //                                    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    //
    //                          cell.titleback.addSubview(blurEffectView)
                              
                    
                    //                    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                    //                    let blurEffectView = UIVisualEffectView(effect: blurEffect)
                    //                    blurEffectView.frame = cell.titleback.bounds
                    //                    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    //                    cell.titleback.addSubview(blurEffectView)
                    
                    
                }
         
                cell.layer.cornerRadius = 5.0
                cell.layer.masksToBounds = true
                
       
                
//                if let viewsnum = book?.views {
//
//                    cell.viewslabel.text = "\(book!.views!)M views"
//
//                } else {
//
//                    cell.viewslabel.text = "6M views"
//
//                }
//
                
                
                
                return cell
                
                //            }
                
            default:
                
                return UICollectionViewCell()
            }
            
        }
        
        @IBOutlet weak var backimage2: UIImageView!
        @IBOutlet weak var depression: UIImageView!
        var selectedindex = Int()
        @IBOutlet weak var genreCollectionView: UICollectionView!
        @IBOutlet weak var titleCollectionView: UICollectionView!
        
        var counter = Int()
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        counter = 0
        
        queryforids { () -> Void in
            
        }
    }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            counter = 0
            
    //        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    //                  let blurEffectView = UIVisualEffectView(effect: blurEffect)
    //                  blurEffectView.frame = backimage.bounds
    //                  blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    //                  backimage.addSubview(blurEffectView)
    //
    //        let blurEffect2 = UIBlurEffect(style: UIBlurEffect.Style.light)
    //                  let blurEffectView2 = UIVisualEffectView(effect: blurEffect)
    //                  blurEffectView2.frame = backimage2.bounds
    //                  blurEffectView2.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    //
            
            
            ref = Database.database().reference()
            
            queryforinfo()
            
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d"
            let result = dateFormatter.string(from: date)
            
            dateformat = result
            
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

            
    //
    //
    //        titleCollectionView.layer.cornerRadius = 10.0
    //        titleCollectionView.clipsToBounds = true
            
            
           
    //        titleCollectionView.reloadData()
            
            //        addstaticbooks()
            
            
            
            //        dayofmonth = "15"
            
            musictimer?.invalidate()
            
            updater?.invalidate()
            player?.pause()
            
            titleCollectionView.layer.cornerRadius = 10.0
            titleCollectionView.clipsToBounds = true
         
    //        layout.itemSize = CGSize(width: screenWidth/2.3, height: screenWidth/1.4)
    //        layout.minimumInteritemSpacing = 0
    //        layout.minimumLineSpacing = 0
    //
    //        titleCollectionView!.collectionViewLayout = layout
            
          var screenSize = titleCollectionView.bounds
               var screenWidth = screenSize.width
               var screenHeight = screenSize.height
    //
               let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                              layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
                   layout.itemSize = CGSize(width: screenWidth/2.35, height: screenHeight/2.4)
                           layout.minimumInteritemSpacing = 0
                           layout.minimumLineSpacing = 0
                   
                              titleCollectionView!.collectionViewLayout = layout
           
            
            
            // Do any additional setup after loading the view.
        }
        
        @objc func swipeR() {
              
            if didpurchase {
                
                bookmarktapped = false
              self.tapPrevious(nil)
                
            } else {
                
                self.performSegue(withIdentifier: "YouToSale", sender: self)

            }
              
          }
          
          @objc func swipeL() {
              
              
              
              if didpurchase {
                
                bookmarktapped = false
                
                    
                       self.tapNext(nil)
                    
                

                     } else {
                         
                         self.performSegue(withIdentifier: "YouToSale", sender: self)

                     }
                       
          }
        
        @IBAction func tapNext(_ sender: AnyObject?) {
              
              
            if counter < books.count-1 {

         taplike.setBackgroundImage(UIImage(named: "DarkBookMark"), for: .normal)
                 
                 bookmarktapped = false
                  
                  counter += 1
                  
              let book = self.book(atIndex: counter)
                         //            if book?.bookID == "Title" {
                         //
                         //                return cell
                         //
                         //            } else {
                         
                         
                         
                let name = book?.name
                let author = book?.author
            id = book?.bookID ?? "x"
    
           
                  
            }
            
          }
        
        @IBAction func tapPrevious(_ sender: AnyObject?) {
                
                taplike.setBackgroundImage(UIImage(named: "DarkBookMark"), for: .normal)
                        
                        bookmarktapped = false
           
            if counter > 0 {
                    counter -= 1
                    
            let book = self.book(atIndex: counter)
                                //            if book?.bookID == "Title" {
                                //
                                //                return cell
                                //
                                //            } else {
                                
                                
                                
                       let name = book?.name
                       let author = book?.author
                   id = book?.bookID ?? "x"

             
              
            }
            
        }
          
            
        func addstaticbooks() {

            var counter2 = 0

            while counter2 < 25 {

             ref?.child("AllBooks1").child(selectedgenre).childByAutoId().updateChildValues(["Name": "x", "Image" : "x", "Author" : "x"])


                counter2 += 1

            }

        }
        
        
            func queryforids(completed: @escaping (() -> Void) ) {

    //                   titleCollectionView.alpha = 0

                       var functioncounter = 0

            

                       ref?.child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in

                           var value = snapshot.value as? NSDictionary

                           print (value)

                           if let snapDict = snapshot.value as? [String: AnyObject] {

                               let genre = Genre(withJSON: snapDict)

                               if let newbooks = genre.books {

                                   self.books = newbooks

                                   self.books = self.books.sorted(by: { $0.popularity ?? 0  > $1.popularity ?? 0 })

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
            
            func queryforinfo() {
                        
                ref?.child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    let value = snapshot.value as? NSDictionary
                    
                    if let purchased = value?["Purchased"] as? String {
                        
                        if purchased == "True" {
                            
                            didpurchase = true
                            
                        } else {
                                         
                            didpurchase = false
                            self.performSegue(withIdentifier: "YouToSale", sender: self)
                            
                        }
                        
                    } else {
                        
                        didpurchase = false
                        self.performSegue(withIdentifier: "YouToSale", sender: self)
                    }
             
                })
                
            }
        
        override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
             if motion == .motionShake {
                 
                 takeScreenshot(true)
                 
             }
         }
        
        var screenshot = UIImage()
        
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

        @IBAction func tapShare(_ sender: Any) {
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                  
                  alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                  
                  alert.addAction(UIAlertAction(title: "Share This Quote", style: .default, handler: { action in
                      switch action.style{
                      case .default:
                          
                          let text = "You need to hear this."
                          
                          var image = self.screenshot
                        
                          let myWebsite = NSURL(string: "https://motivationapp.page.link/share")
                          
                          let shareAll : Array = [text, image, myWebsite] as [Any]
                          
                          
                          let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
                          
                          activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo, UIActivity.ActivityType.saveToCameraRoll, UIActivity.ActivityType.assignToContact]
                          
                          activityViewController.popoverPresentationController?.sourceView = self.view
                          self.present(activityViewController, animated: true, completion: nil)
                      case .cancel:
                          print("cancel")
                          
                      case .destructive:
                          print("destructive")
                          
                          
                      }}))
                  present(alert, animated: true)
        }
        @IBOutlet weak var authorlabel: UILabel!
        
        @IBOutlet weak var taplike: UIButton!
        
        var bookmarktapped = Bool()
        var randomstring = String()
    var id = String()
        
        @IBAction func tapLike(_ sender: Any) {
            
            randomstring = UUID().uuidString
                            
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
            
                if bookmarktapped {
                    
        
                    
                } else {
                    
                ref?.child("Users").child(uid).child(id).removeValue()
                    books.remove(at: counter)

                    counter -= 1
                    
                    tapNext(nil)
                    
                    
                }
                
            
        }
        
        
        
        @IBAction func tapDownvote(_ sender: Any) {
            
            self.tapNext(nil)

        }
        @IBOutlet weak var quotelabel: UILabel!
        

        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */

    }



    extension FavoritesViewController {
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
