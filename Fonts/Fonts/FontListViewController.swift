//
//
// FontListViewController.swift
// Fonts
// titanhood
// Fonts
//
// Created by Ajay Shrivastav on 2022-11-05 on 3:08 AM.


import UIKit

class FontListViewController: UITableViewController {
    var fontNames: [String] = []
    var showsFavorites:Bool = false
    private var cellPointSize: CGFloat!
    private static let cellIdentifier = "FontName"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //familyNames = (UIFont.familyNames as [String]).sorted()
        let preferredTableViewFont =
            UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        cellPointSize = preferredTableViewFont.pointSize
        tableView.estimatedRowHeight = cellPointSize
        
        if showsFavorites {
            navigationItem.rightBarButtonItem = editButtonItem
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func fontForDisplay(atIndexPath indexPath: NSIndexPath) -> UIFont {
         let fontName = fontNames[indexPath.row]
         return UIFont(name: fontName, size: cellPointSize)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         if showsFavorites {
              fontNames = FavoritesList.sharedFavoritesList.favorites
              tableView.reloadData()
         }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using [segue destinationViewController].
            // Pass the selected object to the new view controller.
            let tableViewCell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: tableViewCell)!
            let font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
            
             let sizesVC =  segue.destination as! FontSizesViewController
             sizesVC.title = font.fontName
             sizesVC.font = font
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return showsFavorites
        }
    
    
    
    

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // Return the number of rows in the section.
            return fontNames.count
        }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            FavoritesList.sharedFavoritesList.moveItem(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
            fontNames = FavoritesList.sharedFavoritesList.favorites
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell =  tableView.dequeueReusableCell(
                withIdentifier: FontListViewController.cellIdentifier,
                for: indexPath)
         
         cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath as NSIndexPath)
         cell.textLabel?.text = fontNames[indexPath.row]
         cell.detailTextLabel?.text = fontNames[indexPath.row]
         
         return cell
        }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if !showsFavorites {
                return
            }
            
            if editingStyle == UITableViewCell.EditingStyle.delete {
                // Delete the row from the data source
                let favorite = fontNames[indexPath.row]
                FavoritesList.sharedFavoritesList.removeFavorite(fontName: favorite)
                fontNames = FavoritesList.sharedFavoritesList.favorites
                
                tableView.deleteRows(at: [indexPath],
                                     with: UITableView.RowAnimation.fade)
            }

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
