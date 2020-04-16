//
//  FavoritesWriteViewController.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 4/15/20.
//  Copyright © 2020 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase
import AudioToolbox
import AVFoundation

class FavoritesWriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var books: [Book] = [] {
                didSet {

                    self.tableView.reloadData()

                }
            }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return books.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        let book = self.book(atIndexPath: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Sessions", for: indexPath) as! SessionsTableViewCell
        
        
       
          
          
        cell.datelabel.text = book?.date
          
          let name = book?.name
        
        cell.titlelabel.text = name
        cell.textlabel.text = book?.text1
          

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        queryforids { () -> Void in
                       
                   }

        // Do any additional setup after loading the view.
    }
    
    func queryforids(completed: @escaping (() -> Void) ) {


               var functioncounter = 0

    

               ref?.child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - Helpers
extension FavoritesWriteViewController {
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
