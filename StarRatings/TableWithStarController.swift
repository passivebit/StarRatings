//
//  TableWithStarController.swift
//  ExpandableLabel
//
//  Created by Ritu Raj on 23/02/17.
//  Copyright © 2017 Acknown Technologies. All rights reserved.
//

import UIKit

class TableWithStarController: UIViewController, UITableViewDelegate, UITableViewDataSource, StarRatingDelegate {

    @IBOutlet weak var myTableView: UITableView!
    
    let ttText = "this is a sample text, this is a sample text, this is a sample text, this is a sample text this is a sample text, this is a sample text, this is a sample text, this is a sample text, this is a sample text, this is a sample text, this is a sample text"
    
    var dataSource : [[String : Any]]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.estimatedRowHeight = 70
        myTableView.rowHeight = UITableViewAutomaticDimension
        
        dataSource =
            
                 [
                    ["rating": 4, "text":ttText],["rating": 4, "text":ttText],
                    ["rating": 3, "text":ttText],["rating": 2, "text":ttText],
                    ["rating": 1, "text":ttText],["rating": 5, "text":ttText],
                    ["rating": 4, "text":ttText],["rating": 3, "text":ttText],
                    ["rating": 2, "text":ttText],["rating": 1, "text":ttText],
                    ["rating": 5, "text":ttText],["rating": 4, "text":ttText]
                ]
            
            
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:  - UITableView datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StarCell", for: indexPath) as! StarCell
        
        cell.starRatingView.delegate = self
        cell.starRatingView.utilityTag = indexPath
        cell.starRatingView.setupRating(Float((dataSource?[indexPath.row]["rating"]) as! Int))
        cell.ttLabel.text = dataSource?[indexPath.row]["text"] as? String
        
        return cell
    }
    
    //MARK: UITableView delegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row at index path \(indexPath)")
    }
    
    //MARK : StarRatingDelegate
    
    func didTapStarNumber(starNumber: (Int, Any)) {
        
        print("clicked at star \(starNumber.0) at cell index \(starNumber.1 as! NSIndexPath)")
        let index = starNumber.1 as! NSIndexPath
//        dataSource[index.row]["rating"] = starNumber.0
        dataSource?[index.row]["rating"] = starNumber.0
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
