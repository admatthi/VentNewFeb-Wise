//
//  ForYouViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 4/1/20.
//  Copyright © 2020 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase
import FBSDKCoreKit

class ForYouViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var books: [Book] = [] {
        
        
        didSet {
            
            
            collectionView.reloadData()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let book = self.book(atIndexPath: indexPath)
        collectionView.alpha = 1
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "For You", for: indexPath) as! TitleCollectionViewCell
        //
        //            if book?.bookID == "Title" {
        //
        //                return cell
        //
        //            } else {
        
        
                
        let date = Date()
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "MMM d"
             var result = dateFormatter.string(from: date)

                            dateformat = result
                          
             dateFormatter.dateFormat = "yyyy-MM-dd"

             result = dateFormatter.string(from: date)
             var weekday = (Date().dayOfWeek()!)
          
                 
        cell.datelabel.text = String(weekday)
        
        
        cell.titleImage.image = backgroundimages[backgroundcounter]


       
        
        //                cell.tapup.tag = indexPath.row
        //
        //                cell.tapup.addTarget(self, action: #selector(DiscoverViewController.tapWishlist), for: .touchUpInside)
        
     
        
      
  
        cell.layer.cornerRadius = 10.0
        cell.layer.masksToBounds = true
        
        
        
      
        
        
        return cell
    }
    @IBOutlet weak var backimage: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        backimage.layer.cornerRadius = 5.0
        backimage.clipsToBounds = true
        queryforinfo()
        
        selectedgenre = "For You"
        
        var screenSize = collectionView.bounds
                   var screenWidth = screenSize.width
                   var screenHeight = screenSize.height

                   let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                   layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/1.1, height: screenWidth/5)
                   layout.minimumInteritemSpacing = 0
                   layout.minimumLineSpacing = 0

                   collectionView!.collectionViewLayout = layout
        
        queryforids { () -> Void in
            
        }
        
        backgroundimages.removeAll()
               backgroundimages.append(UIImage(named: "sunrise1")!)
               backgroundimages.append(UIImage(named: "sunrise2")!)
               backgroundimages.append(UIImage(named: "sunrise3")!)
               backgroundimages.append(UIImage(named: "sunrise4")!)
                 backgroundimages.append(UIImage(named: "sunrise5")!)
                 backgroundimages.append(UIImage(named: "sunrise6")!)
               backgroundimages.append(UIImage(named: "sunrise7")!)
                 backgroundimages.append(UIImage(named: "sunrise8")!)
                 backgroundimages.append(UIImage(named: "sunrise9")!)
               backgroundimages.append(UIImage(named: "sunrise10")!)
                 backgroundimages.append(UIImage(named: "sunrise11")!)
                 backgroundimages.append(UIImage(named: "sunrise12")!)
               
               backgroundcounter = Int.random(in: 0..<backgroundimages.count)
               
        // Do any additional setup after loading the view.
    }
    
    var backgroundcounter = Int()
    
    func queryforids(completed: @escaping (() -> Void) ) {
        
        //                   titleCollectionView.alpha = 0
        
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
                    self.performSegue(withIdentifier: "ForYouToSale", sender: self)
                    
                }
                
            } else {
                
                didpurchase = false
                self.performSegue(withIdentifier: "ForYouToSale", sender: self)
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

extension ForYouViewController {
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
