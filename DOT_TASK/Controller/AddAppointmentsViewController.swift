//
//  AddAppointmentsViewController.swift
//  DOT_TASK
//
//  Created by Aakash Sinha on 12/11/20.
//  Copyright © 2020 Aakash Sinha. All rights reserved.
//

import UIKit
import BottomPopup
import MapKit

class AddAppointmentsViewController: BottomPopupViewController {

    @IBOutlet weak var day: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var purpose: UILabel!
    @IBOutlet weak var doctorName: UILabel!
    var detailsArray = [String]()
    
    override var popupHeight: CGFloat{
        return  UIScreen.main.bounds.size.height/1.2

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
         
         loadData()
        
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        time.text = detailsArray[0]
        day.text = detailsArray[2]
        doctorName.text = detailsArray[1]
        purpose.text = detailsArray[3]
    }
    
    @IBAction func dismissPopUp(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
  

}
