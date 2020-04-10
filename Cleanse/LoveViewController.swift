//
//  LoveViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 3/19/20.
//  Copyright © 2020 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase
import FBSDKCoreKit

class LoveViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
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
    
    
    @IBOutlet weak var backimage: UIImageView!
    var books: [Book] = [] {
        didSet {
            
            bookmarktapped = false
            
            let book = self.book(atIndex: 0)
            //            if book?.bookID == "Title" {
            //
            //                return cell
            //
            //            } else {
            
            
            
            let name = book?.name
            let author = book?.author
            
            let publisheddate = book?.date ?? "2020-03-31 14:37:21"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = dateFormatter.date(from:publisheddate)!

            let dateago = date.timeAgoSinceDate()
            
            print(dateago)
            
//            timeagolabel.text = dateago
            
            let myIndexPath = IndexPath(row: 1, section: 0)
                      
                      
                      titleCollectionView.scrollToItem(at: myIndexPath, at: UICollectionView.ScrollPosition.top, animated: false)
                      
            
            titleCollectionView.reloadData()
            genreCollectionView.reloadData()
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
    
    @IBOutlet weak var blur: UIButton!
    @IBAction func tapBlur(_ sender: Any) {
        
        self.performSegue(withIdentifier: "HappyToSale", sender: self)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        refer = "On Tap Discover"
        counter = 0
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        self.view.endEditing(true)
        
        if collectionView.tag == 1 {
            
            selectedindex = indexPath.row
            
            logGenreViewed(referrer: referrer)
            genreCollectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            
            collectionView.alpha = 0
            
            selectedgenre = genres[indexPath.row]
            
            genreindex = indexPath.row
            
            queryforids { () -> Void in
                
            }
            
            //            titleCollectionView.scrollToItem(at: indexPath, at: .top, animated: false)
            
            
            genreCollectionView.reloadData()
            
            
            
        } else {
            
            let book = self.book(atIndexPath: indexPath)
            selectedamazonurl = selectedgenre

            
            headlines.removeAll()
            
            bookindex = indexPath.row
            selectedauthorname = book?.author ?? ""
            selectedtitle = book?.name ?? ""
            selectedurl = book?.audioURL ?? ""
            selectedbookid = book?.bookID ?? ""
            selectedgenre = book?.genre ?? ""
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
                   headlines.append(book?.headline9 ?? "x")
                   headlines.append(book?.headline10 ?? "x")
                   headlines.append(book?.headline11 ?? "x")
                   headlines.append(book?.headline12 ?? "x")
                   headlines.append(book?.headline13 ?? "x")
                   headlines.append(book?.headline14 ?? "x")
                   headlines.append(book?.headline15 ?? "x")
                   headlines.append(book?.headline16 ?? "x")
                   headlines.append(book?.headline17 ?? "x")
                   headlines.append(book?.headline18 ?? "x")
                   headlines.append(book?.headline19 ?? "x")
                   headlines.append(book?.headline20 ?? "x")

                   headlines.append(book?.headline21 ?? "x")
                         headlines.append(book?.headline22 ?? "x")
                         headlines.append(book?.headline23 ?? "x")
                         headlines.append(book?.headline24 ?? "x")
                         headlines.append(book?.headline25 ?? "x")
                         headlines.append(book?.headline26 ?? "x")
                         headlines.append(book?.headline27 ?? "x")
                         headlines.append(book?.headline28 ?? "x")
                         headlines.append(book?.headline29 ?? "x")
                         headlines.append(book?.headline30 ?? "x")
            
            
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
                    
                    self.performSegue(withIdentifier: "LoveToRead", sender: self)
                    
                    
                } else {
                    
                    
                    self.performSegue(withIdentifier: "LoveToRead", sender: self)
                    
                }
            } else {
                
                self.performSegue(withIdentifier: "LoveToRead", sender: self)
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
    func addstaticbooks() {
        
        var counter2 = 0
        
        while counter2 < 15 {
            
            ref?.child("AllBooks1").child(selectedgenre).childByAutoId().updateChildValues(["Name": "x", "Image" : "x", "Author" : "Brian Stevens", "Genre" : "x", "Headline1" : "x", "Headline2" : "x", "Headline3" : "x", "Headline4" : "x", "Headline5" : "x", "Headline6" : "x", "Headline7" : "x", "Headline8" : "x", "Headline9" : "x", "Headline10" : "x", "Headline11" : "x", "Headline12" : "x", "Headline13" : "x", "Headline14" : "x", "Headline15" : "x", "Headline16" : "x", "Headline17" : "x", "Headline18" : "x", "Headline19" : "x", "Headline20" : "x", "Headline21" : "x", "Headline22" : "x", "Headline23" : "x", "Headline24" : "x", "Headline25" : "x", "Headline26" : "x", "Headline27" : "x", "Headline28" : "x", "Headline29" : "x", "Headline30" : "x", "Headline31" : "x", "Author Image" : "https://images.unsplash.com/photo-1541418950054-c12804e149d9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60", "Description" : "x", "Profession" : "x"])
            
            
            counter2 += 1
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        // Genre collection
        case self.genreCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Categories", for: indexPath) as! GenreCollectionViewCell
            
            collectionView.alpha = 1
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
            
//            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
//               let blurEffectView = UIVisualEffectView(effect: blurEffect)
//               blurEffectView.frame = cell.backlabel.bounds
//               blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//            cell.backlabel.addSubview(blurEffectView)
            

            if let imageURLString = book?.imageURL, let imageUrl = URL(string: imageURLString) {

                                             cell.titleImage.kf.setImage(with: imageUrl)
                       
                       }//            cell.backlabel.image = backgroundimages[backgroundcounter]
        
            var viewscounter =  book?.profession
            cell.viewslabel.text = viewscounter

                cell.titlelabel.text = name
            //                       cell.titleback.clipsToBounds = true
            
            cell.layer.cornerRadius = 10.0
            cell.layer.cornerRadius = 10.0
            
            
            //                cell.tapup.tag = indexPath.row
            //
            //                cell.tapup.addTarget(self, action: #selector(DiscoverViewController.tapWishlist), for: .touchUpInside)
            
            

   
                
                
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
                
                
            
      
            
            
            cell.layer.cornerRadius = 5.0
            cell.layer.masksToBounds = true
            
            
//
//            if let viewsnum = book?.views {
//
//                cell.viewslabel.text = "\(book!.views!)M views"
//
//            } else {
//
//                cell.viewslabel.text = "6M views"
//
//            }
            
            
                     if name == "x" {
                         
                         cell.titlelabel.alpha = 0
                         cell.backlabel.alpha = 0
                         cell.viewslabel.alpha = 0
                         cell.titleImage.alpha = 0
                         cell.greylabel.alpha = 0
                       } else {
                                     
                                     cell.titlelabel.alpha = 1
                                            cell.backlabel.alpha = 1
                                            cell.viewslabel.alpha = 1
                                            cell.titleImage.alpha = 1
                                            cell.greylabel.alpha = 1
                                 }
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
    var genres = [String]()

    @IBAction func tapDelete(_ sender: Any) {
        
        ref?.child("AllBooks1").child(selectedgenre).child(id).removeValue()
        
        tapNext(nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
      
         
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let swipeLeftRec = UISwipeGestureRecognizer()
        let swipeUpRec = UISwipeGestureRecognizer()
        let swipeDownRec = UISwipeGestureRecognizer()
        let swipeRightRec = UISwipeGestureRecognizer()
        
//                    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
//                       let blurEffectView = UIVisualEffectView(effect: blurEffect)
//                       blurEffectView.frame = backimage2.bounds
//                       blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        
//                    backimage2.addSubview(blurEffectView)
      
        
        ref = Database.database().reference()
        
        
        queryforinfo()
        
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        let result = dateFormatter.string(from: date)
        
        dateformat = result
        

        genres.removeAll()
              genres.append("Relationships")
              genres.append("Self")
              genres.append("Family")
                   
            
               selectedgenre = genres[0]
                 selectedindex = 0
                 
                 genreCollectionView.reloadData()
            
            queryforids { () -> Void in
                
            }
            
            
        
        var screenSize = titleCollectionView.bounds
          var screenWidth = screenSize.width
          var screenHeight = screenSize.height

        
                      let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                   layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        layout.itemSize = CGSize(width: screenWidth/2.35, height: screenHeight/2.4)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
        
                   titleCollectionView!.collectionViewLayout = layout
        
        titleCollectionView.layer.cornerRadius = 10.0
        titleCollectionView.clipsToBounds = true
        
        
        backimage2.layer.cornerRadius = 10.0
        backimage2.clipsToBounds = true

        
        //        addstaticbooks()
        
        
        
        //        dayofmonth = "15"
        
        musictimer?.invalidate()
        
        updater?.invalidate()
        player?.pause()
        
        
        
        bookmarktapped = false
        
        
        // Do any additional setup after loading the view.
    }
    
    var backgroundcounter = Int()
    
    @objc func swipeR() {
        
        bookmarktapped = false
        taplike.setBackgroundImage(UIImage(named: "LightBookMark"), for: .normal)
        
        self.tapPrevious(nil)
        
    }
    
    @objc func swipeL() {
        
        
        bookmarktapped = false
        taplike.setBackgroundImage(UIImage(named: "LightBookMark"), for: .normal)
        
        self.tapNext(nil)
        
        
        
        
    }
    
    @IBAction func tapNext(_ sender: AnyObject?) {
        
        

        counter += 1
        
        if counter < books.count {
            
            print("books = \(books.count) and \(counter)")

            swipeRight(referrer: referrer)
            
            
//            backimage2.slideInFromBottom()
//            tapdownvote.slideInFromBottom()
//             tapshare.slideInFromBottom()
//            taplike.slideInFromBottom()

        let book = self.book(atIndex: counter)
        //            if book?.bookID == "Title" {
        //
        //                return cell
        //
        //            } else {
        
        
        
        let name = book?.name
        let author = book?.author
            let publisheddate = book?.date ?? "2020-03-31 14:37:21"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = dateFormatter.date(from:publisheddate)!

            let dateago = date.timeAgoSinceDate()
            
            print(dateago)
            
            timeagolabel.text = dateago
            
        id = book?.bookID ?? "x"
        
        quotelabel.text = name
        authorlabel.text = author
            
            fullview.slideInFromBottom()

        
//        quotelabel.slideInFromBottom()
//        authorlabel.slideInFromBottom()
            
        }
        
        
    }
    @IBOutlet weak var fullview: UIView!
    
    var bookmarktapped = Bool()
    var randomstring = String()
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
        self.tapNext(nil)
        
    }
    @IBOutlet weak var taplike: UIButton!
    
    var id = String()
    
    @IBAction func tapLike(_ sender: Any) {
        
        randomstring = UUID().uuidString
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        if bookmarktapped {
            
            ref?.child("Users").child(uid).child(id).removeValue()
            
            taplike.setBackgroundImage(UIImage(named: "LightBookMark"), for: .normal)
            
            bookmarktapped = false
            
        } else {
            
            taplike.setBackgroundImage(UIImage(named: "DarkBookMark"), for: .normal)
            
            var trimmedtext = String()
            logFavoriteTapped(referrer: referrer)
            
            trimmedtext = quotelabel.text ?? "x"
            
            var authorget = authorlabel.text ?? "x"
            ref?.child("Users").child(uid).child(id).updateChildValues(["Name" : trimmedtext, "Author" : authorget])
                        
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
            
            ref?.child("AllBooks1").child(selectedgenre).child(id).updateChildValues(["Date" : myString])

            bookmarktapped = true
            
        }
        
    }
    
    @IBOutlet weak var likeslabel: UILabel!
    
    @IBOutlet weak var timeagolabel: UILabel!
    
    @IBAction func tapPrevious(_ sender: AnyObject?) {
        
        
        if counter > 0 {
            
            
            counter -= 1
            
            var backgroundcounter = Int.random(in: 0..<backgroundimages.count)
                                   backimage2.image = backgroundimages[backgroundcounter]
//                     backimage2.slideInFromTop()
//            tapdownvote.slideInFromTop()
//            tapshare.slideInFromTop()
//            taplike.slideInFromTop()
            let book = self.book(atIndex: counter)
            //            if book?.bookID == "Title" {
            //
            //                return cell
            //
            //            } else {
            
            
            
            let name = book?.name
            let author = book?.author
            
            id = book?.bookID ?? "x"
            let publisheddate = book?.date ?? "2020-03-31 14:37:21"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = dateFormatter.date(from:publisheddate)!

            let dateago = date.timeAgoSinceDate()
            
            print(dateago)
            
            timeagolabel.text = dateago
            quotelabel.text = name
            authorlabel.text = author
            
            blur.slideInFromTop()
//            quotelabel.slideInFromTop()
//            authorlabel.slideInFromTop()
//            backimage2.slideInFromTop()
//
            fullview.slideInFromTop()

            if didpurchase {
                
                quotelabel.alpha = 1
                authorlabel.alpha = 1
                blur.alpha = 0
            } else {
                
                quotelabel.alpha = 0
                authorlabel.alpha = 0
                blur.alpha = 1
            }
            
        }
        
    }
    func queryforids(completed: @escaping (() -> Void) ) {
        
        var functioncounter = 0
        
        
        
        ref?.child("AllBooks1").child(selectedgenre).observeSingleEvent(of: .value, with: { (snapshot) in
            
            var value = snapshot.value as? NSDictionary
            
            print (value)
            
            if let snapDict = snapshot.value as? [String: AnyObject] {
                
                let genre = Genre(withJSON: snapDict)
                
                if let newbooks = genre.books {
                    
                    self.books = newbooks
                    
                    self.books = self.books.sorted(by: { $0.date ?? "2020-02-28 14:51:06"  > $1.date ?? "2020-02-28 14:51:06" })
                    
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
    
    @IBOutlet weak var quotelabel: UILabel!
    
    @IBOutlet weak var authorlabel: UILabel!
    
    func queryforinfo() {
        
        ref?.child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            if let purchased = value?["Purchased"] as? String {
                
                if purchased == "True" {
                    
                    didpurchase = true
                    
                } else {
                    
                    didpurchase = false
                    
                }
                
            } else {
                
                didpurchase = false
            }
            
        })
        
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

    extension LoveViewController {
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

