//
//  AppointmentViewController.swift
//  DOT_TASK
//
//  Created by Aakash Sinha on 12/11/20.
//  Copyright © 2020 Aakash Sinha. All rights reserved.
//

import UIKit

class AppointmentViewController: UIViewController {
    @IBOutlet weak var addButtonView: UIView!
    var convertedDay = [String]()
    var convertedMonth = [String]()
    var apptDate : String = ""
    var convtDate = [String]()
    var pastAppointmentsArray = [AppointmentsHistory]()
    var apiManager = ApiManager()
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var addAppointments: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiManager.delegate = self
        setButtonProperties()
        apiManager.fetchMatch()
        tableView.register(UINib(nibName: "AppointmentListTableViewCell", bundle: nil), forCellReuseIdentifier: AppointmentListTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showSpinner(onView: self.view)
    }
    
    
    
    func setButtonProperties() {
        addButtonView.layer.cornerRadius = addButtonView.frame.height * 0.50
        addAppointments.layer.cornerCurve = .continuous
        addAppointments.layer.cornerRadius = addAppointments.frame.height * 0.50
        addAppointments.clipsToBounds = true
        addAppointments.layer.borderWidth = 2
        addAppointments.layer.borderColor = #colorLiteral(red: 0.1523728655, green: 0.07062042452, blue: 0.3033089791, alpha: 1)
    }
    
    @IBAction func appointmentsTapped(_ sender: UIButton) {
        
        
    }
    
    
    
}

extension AppointmentViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cnt = 0
        if pastAppointmentsArray.count != 0 {
            cnt =  pastAppointmentsArray[0].data.count
        }
        return cnt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AppointmentListTableViewCell
        
        if  pastAppointmentsArray.count != 0 {
            
            apptDate = pastAppointmentsArray[0].data[indexPath.row].appointment_slot_info.slot_date
            convtDate = dateConverter(dateString: apptDate)
            
            cell.dateLabel.text = convtDate[indexPath.row]
            cell.monthLabel.text = "June"
            cell.doctorName.text = pastAppointmentsArray[0].data[indexPath.row].appointment_provider_info.provider_name + " , " + pastAppointmentsArray[0].data[indexPath.row].appointment_provider_info.provider_type
            cell.doctorsDetails.text = "Genenral Assistant , American hospital"
            
            cell.status.text = pastAppointmentsArray[0].data[indexPath.row].appointment_info.status
            switch cell.status.text {
            case "scheduled":
                cell.ststusView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                
            case "missed" :
                cell.ststusView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            default:
                cell.ststusView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            }
            
            cell.time.text = pastAppointmentsArray[0].data[indexPath.row].appointment_slot_info.end_time
            cell.apptFor.text = pastAppointmentsArray[0].data[indexPath.row].appointment_info.purpose
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let time = pastAppointmentsArray[0].data[indexPath.row].appointment_slot_info.end_time
        let name = pastAppointmentsArray[0].data[indexPath.row].appointment_provider_info.provider_name + " , " + pastAppointmentsArray[0].data[indexPath.row].appointment_provider_info.provider_type
        let day = convtDate[indexPath.row]
        let purpose =  pastAppointmentsArray[0].data[indexPath.row].appointment_info.purpose
        print(time)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "details") as! AddAppointmentsViewController
        var details = [String]()
        details.append(time)
        details.append(name)
        details.append(day)
        details.append(purpose)
        
        newVC.detailsArray = details

        
        self.show(newVC, sender: self)
    }
    
    func dateConverter(dateString : String) -> [String] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: dateString) else {
            return []
        }
        
        formatter.dateFormat = "yyyy"
        //let year = formatter.string(from: date)
        
        formatter.dateFormat = "MM"
        let month = formatter.string(from: date)
        
        formatter.dateFormat = "dd"
        let day = formatter.string(from: date)
        
        convertedDay.append(day)
        convertedMonth.append(month)
        
        return convertedDay
    }
    
    
}


extension AppointmentViewController : ApiManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateList(_ apiManager: ApiManager, pastList: [AppointmentsHistory]) {
        pastAppointmentsArray = []
        for arr in pastList {
            pastAppointmentsArray.append(arr)
        }
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.removeSpinner()
        }
        
        
        
    }
    
    
}
