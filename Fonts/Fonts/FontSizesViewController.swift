//
//
// FontSizesViewController.swift
// Fonts
// titanhood
// Fonts
//
// Created by Ajay Shrivastav on 2022-11-05 on 3:27 AM.


import UIKit

class FontSizesViewController: UITableViewController {
    var font: UIFont!
    private static let pointSizes: [CGFloat] = [
        9, 10, 11, 12, 13, 14, 18, 24, 36, 48, 64, 72, 96, 144
    ]
    private static let cellIdentifier = "FontNameAndSize"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = FontSizesViewController.pointSizes[0]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont {
            let pointSize = FontSizesViewController.pointSizes[indexPath.row]
            return font.withSize(pointSize)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using [segue destinationViewController].
            // Pass the selected object to the new view controller.
            let tableViewCell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: tableViewCell)!
            let font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
            
            if segue.identifier == "ShowFontSizes" {
                let sizesVC =  segue.destination as! FontSizesViewController
                sizesVC.title = font.fontName
                sizesVC.font = font
            } else {
                let infoVC = segue.destination as! FontInfoViewController
                infoVC.title = font.fontName
                infoVC.font = font
                infoVC.favorite =
                    FavoritesList.sharedFavoritesList.favorites.contains(font.fontName)
            }
        }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return FontSizesViewController.pointSizes.count
       }

       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(
               withIdentifier: FontSizesViewController.cellIdentifier,
               for: indexPath)
           
           cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
           cell.textLabel?.text = font.fontName
           cell.detailTextLabel?.text =
               "\(FontSizesViewController.pointSizes[indexPath.row]) point"
           
           return cell
       }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
