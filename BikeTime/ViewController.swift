//
//  ViewController.swift
//  BikeTime
//
//  Created by Alex Dearden on 19/1/16.
//  Copyright © 2016 bitfountain. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBOutlet weak var modelLabel: UILabel!
    
    @IBOutlet weak var forkLabel: UILabel!
    
    @IBOutlet weak var wheelLabel: UILabel!
    
    @IBOutlet weak var notificationsLabel: UILabel!
    
    var context: NSManagedObjectContext?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Show the bikes when app starts
        guard let context = context, existingBikes = fetchBikes(context), currentBike = existingBikes.last else { return }
        updateUI(currentBike)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addButtonTapped(sender: UIButton) {
    }
    
    // MARK: Methods called in IBActions
    func updateUI(bike: Bike) {
        let bikeInfo = bikeToDescription(bike)
        modelLabel.text = bikeInfo.model
        forkLabel.text = bikeInfo.fork
        wheelLabel.text = bikeInfo.wheelSize
    }
    
    // Helper function to return unwrapped values
    func bikeToDescription(bike: Bike)-> (name: String, model: String, fork: String, wheelSize: String) {
        guard let name = bike.name, model = bike.model, fork = bike.fork, wheelSize = bike.wheelSize else { return (name: "", model: "", fork: "", wheelSize: "") }
        return (name: name, model: model, fork: fork, wheelSize: wheelSize.description)
    }
      

}

