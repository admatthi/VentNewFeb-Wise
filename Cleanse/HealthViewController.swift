//
//  HealthViewController.swift
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
class HealthViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    var id = String()
    
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
            id = book?.bookID ?? "x"
            quotelabel.text = name
            authorlabel.text = author
            
            if didpurchase {
                
                quotelabel.alpha = 1
                authorlabel.alpha = 1
                blur.alpha = 0
            } else {
                
                
                quotelabel.alpha = 0
                authorlabel.alpha = 0
                blur.alpha = 1
                blur.slideInFromRight()
            }
            
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        refer = "On Tap Discover"
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        self.view.endEditing(true)
        
        
        if collectionView.tag == 1 {
            counter = 0
            
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
            
            blur.slideInFromRight()
            
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
                    
                    self.performSegue(withIdentifier: "HealthToConsume", sender: self)
                    
                    
                } else {
                    
                    
                    self.performSegue(withIdentifier: "HealthToSale1", sender: self)
                    
                }
            } else {
                
                self.performSegue(withIdentifier: "HealthToConsume", sender: self)
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
            
            cell.genrelabel.text = book?.author
            
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
            
            
            if indexPath.row > 4 {
                
                if didpurchase {
                    
                    cell.titlelabel.alpha = 1
                    cell.blur.alpha = 0
                    cell.backlabel.alpha = 0.8
                    cell.titleImage.alpha = 1
                    
                } else {
                    
                    
                    
                    cell.titlelabel.alpha = 0
                    cell.blur.alpha = 1
                    cell.backlabel.alpha = 0.95
                    cell.titleImage.alpha = 0
                    
                    
                }
            } else {
                
                cell.titlelabel.alpha = 1
                cell.blur.alpha = 0
                cell.backlabel.alpha = 0.8
                cell.titleImage.alpha = 1
            }
            
            
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
            
            let isWished = Bool()
            
            if wishlistids.contains(book!.bookID) {
                
                
            } else {
                
            }
            
            cell.layer.cornerRadius = 5.0
            cell.layer.masksToBounds = true
            
            
            
            if let viewsnum = book?.views {
                
                cell.viewslabel.text = "\(book!.views!)M views"
                
            } else {
                
                cell.viewslabel.text = "6M views"
                
            }
            
            
            
            
            return cell
            
            //            }
            
        default:
            
            return UICollectionViewCell()
        }
        
    }
    func addstaticbooks() {
        
        var counter2 = 0
        
        while counter2 < 25 {
            
            ref?.child("AllBooks1").child(selectedgenre).childByAutoId().updateChildValues(["Name": "x", "Image" : "x", "Author" : "x"])
            
            
            counter2 += 1
            
        }
        
    }
    @IBOutlet weak var backimage2: UIImageView!
    @IBOutlet weak var depression: UIImageView!
    var selectedindex = Int()
    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var titleCollectionView: UICollectionView!
    
    @IBAction func tapDelete(_ sender: Any) {
        
        ref?.child("AllBooks1").child(selectedgenre).child(id).removeValue()
        
        tapNext(nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        genres.removeAll()
        genres.append("Dieting")
        genres.append("Exercise")
        genres.append("Illness")
        if didpurchase {
            
            quotelabel.alpha = 1
            authorlabel.alpha = 1
            blur.alpha = 0
        } else {
            
            quotelabel.alpha = 0
            authorlabel.alpha = 0
            blur.alpha = 1
        }
        
        selectedgenre = "Dieting"
        
        queryforids { () -> Void in
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let swipeLeftRec = UISwipeGestureRecognizer()
        let swipeUpRec = UISwipeGestureRecognizer()
        let swipeDownRec = UISwipeGestureRecognizer()
        let swipeRightRec = UISwipeGestureRecognizer()
        
        swipeRightRec.addTarget(self, action: #selector(self.swipeR) )
        swipeRightRec.direction = .right
        self.view!.addGestureRecognizer(swipeRightRec)
        
        
        swipeLeftRec.addTarget(self, action: #selector(self.swipeL) )
        swipeLeftRec.direction = .left
        
        self.view!.addGestureRecognizer(swipeLeftRec)
        
        ref = Database.database().reference()
        
        queryforinfo()
        
        selectedgenre = "Dieting"
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        let result = dateFormatter.string(from: date)
        
        dateformat = result
        
        
        
        
        
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
    
    @objc func swipeR() {
        
        bookmarktapped = false
        taplike.setBackgroundImage(UIImage(named: "LightBookMark"), for: .normal)
        
        self.tapPrevious(nil)
        
    }
    
    @objc func swipeL() {
        
        
        if counter <= books.count {

        bookmarktapped = false
        taplike.setBackgroundImage(UIImage(named: "LightBookMark"), for: .normal)
        
        self.tapNext(nil)
        
        
        }
        
    }
    
    @IBAction func tapNext(_ sender: AnyObject?) {
        
        
        
        
        counter += 1
        
        if counter < books.count {

        let book = self.book(atIndex: counter)
        //            if book?.bookID == "Title" {
        //
        //                return cell
        //
        //            } else {
        
        
        
        let name = book?.name
        let author = book?.author
        
        quotelabel.text = name
        authorlabel.text = author
        id = book?.bookID ?? "x"
        quotelabel.slideInFromRight()
        authorlabel.slideInFromRight()
        
        if didpurchase {
            
            quotelabel.alpha = 1
            authorlabel.alpha = 1
            blur.alpha = 0
        } else {
            
            
            quotelabel.alpha = 0
            authorlabel.alpha = 0
            blur.alpha = 1
            blur.slideInFromRight()
        }
            
        }
        
    }
    
    var bookmarktapped = Bool()
    var randomstring = String()
    
    @IBOutlet weak var taplike: UIButton!
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
        let text = "You need to hear this."
                             
                             var image = self.screenshot
                           
                             let myWebsite = NSURL(string: "https://motivationapp.page.link/share")
                             
                             let shareAll : Array = [text, image, myWebsite] as [Any]
                             
                             
                             let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
                             
                             activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo, UIActivity.ActivityType.saveToCameraRoll, UIActivity.ActivityType.assignToContact]
                             
                             activityViewController.popoverPresentationController?.sourceView = self.view
                             self.present(activityViewController, animated: true, completion: nil)
    }
    @IBAction func tapDownvote(_ sender: Any) {
        
        logTapDownvote(referrer: referrer)
        self.tapNext(nil)
        
    }
    
    @IBOutlet weak var blur: UIButton!
    @IBAction func tapBlur(_ sender: Any) {
        
        self.performSegue(withIdentifier: "HealthToSale1", sender: self)
        
    }
    
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
            
            bookmarktapped = true
            
        }
        
        
    }
    
    
    @IBAction func tapPrevious(_ sender: AnyObject?) {
        
        
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
            
            quotelabel.text = name
            authorlabel.text = author
            id = book?.bookID ?? "x"
            quotelabel.slideInFromLeft()
            authorlabel.slideInFromLeft()
            
        }
        
        if didpurchase {
            
            quotelabel.alpha = 1
            authorlabel.alpha = 1
            blur.alpha = 0
        } else {
            
            
            quotelabel.alpha = 0
            authorlabel.alpha = 0
            blur.alpha = 1
            blur.slideInFromLeft()
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
                    self.performSegue(withIdentifier: "HealthToSale1", sender: self)
                    
                }
                
            } else {
                
                didpurchase = false
                self.performSegue(withIdentifier: "HealthToSale1", sender: self)
            }
            
        })
        
    }
    
    @IBOutlet weak var quotelabel: UILabel!
    
    @IBOutlet weak var authorlabel: UILabel!
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

    extension HealthViewController {
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

