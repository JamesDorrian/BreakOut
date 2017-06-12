//
//  SettingsVC.swift
//  Breakout
//
//  Created by James Dorrian on 23/04/2017.
//  Copyright © 2017 JD_13369451. All rights reserved.
//

import Foundation
import UIKit


class SettingsVC: UITableViewController {
    
    @IBOutlet weak var bounceControlSlider: UISlider! {
        didSet {
            let bounceQ = Float(GlobalAttributes.sharedInstance.bounce)
            bounceControlSlider.value = bounceQ
        }
    }
    @IBAction func controlBounce(_ sender: UISlider) {
        let bounceQ = CGFloat(sender.value)
        GlobalAttributes.sharedInstance.bounce = bounceQ
        bounceLabel.text = String(describing: bounceQ)
    }
    
    @IBOutlet weak var bounceLabel: UILabel!
    @IBOutlet weak var ballControlSegment: UISegmentedControl!
    @IBAction func controlBallColor(_ sender: UISegmentedControl) {
        highScoreLabel.text = String(Int(GlobalAttributes.sharedInstance.numberOfRows)*5)
        switch sender .selectedSegmentIndex{
            case 0:
                GlobalAttributes.sharedInstance.ballColor = "red"
                break
            case 1:
                GlobalAttributes.sharedInstance.ballColor = "green"
                break
            case 2:
                GlobalAttributes.sharedInstance.ballColor = "blue"
                break
            case 3:
                GlobalAttributes.sharedInstance.ballColor = "black"
                break
            case 4:
                GlobalAttributes.sharedInstance.ballColor = "white"
                break
            case 5:
                GlobalAttributes.sharedInstance.ballColor = "orange"
                break
            default: break
        }
        
    }
    
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!{
        didSet {
            stepLabel.text = String(stepper.value)
        }
    }

    //number of blocks control (rows)
    @IBAction func blockNumberStepper(_ sender: UIStepper) {
        stepLabel.text = String(stepper.value*5) //5 cols per row
        GlobalAttributes.sharedInstance.numberOfRows = stepper.value
    }
    
    func setScore(){
        GlobalAttributes.sharedInstance.highScore = (Int(GlobalAttributes.sharedInstance.numberOfRows)*5)
        //highScoreLabel.text = String(Int(GlobalAttributes.sharedInstance.numberOfRows)*5)
    }
    
    
    
    @IBOutlet weak var highScoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        highScoreLabel.text = String(GlobalAttributes.sharedInstance.highScore)
        stepper.maximumValue = 5
        stepper.minimumValue = 1
        stepper.stepValue = 1
        stepLabel.text = String(stepper.value*5)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
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
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
