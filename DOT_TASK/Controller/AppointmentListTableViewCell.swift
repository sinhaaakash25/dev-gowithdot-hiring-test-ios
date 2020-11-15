//
//  AppointmentListTableViewCell.swift
//  DOT_TASK
//
//  Created by Aakash Sinha on 12/11/20.
//  Copyright © 2020 Aakash Sinha. All rights reserved.
//

import UIKit

class AppointmentListTableViewCell: UITableViewCell {
    
    static var nib  : UINib{

        return UINib(nibName: "AppointListTableViewCell", bundle: nil)

    }

    static var identifier : String{

        return "cell"

    }

    @IBOutlet weak var ststusView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var doctorName: UILabel!
    
    @IBOutlet weak var doctorsDetails: UILabel!
    
    @IBOutlet weak var apptFor: UILabel!
    
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var diseaseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        diseaseView.layer.cornerRadius = 5
        ststusView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
