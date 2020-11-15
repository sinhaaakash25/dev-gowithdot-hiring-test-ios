//
//  AppointmentsHistory.swift
//  DOT_TASK
//
//  Created by Aakash Sinha on 12/11/20.
//  Copyright © 2020 Aakash Sinha. All rights reserved.
//

import Foundation

struct AppointmentsHistory : Codable{
        var data: [Datum]
        
    }

    // MARK: - Datum
    struct Datum: Codable {
        var appointment_info: AppointmentInfo
        var appointment_provider_info: AppointmentProviderInfo
        var appointment_slot_info: AppointmentSlotInfo

       
    }

    // MARK: - AppointmentInfo
    struct AppointmentInfo: Codable {
        var appointment_id: Int
        var doctor_slot_id: Int?
        var patient_id: Int
        var payment_amount: String
        var payment_id: Int
        var purpose: String
        var remarks: String
        var status: String
        var facility_slot_id: Int?

        
    }


    // MARK: - AppointmentProviderInfo
    struct AppointmentProviderInfo: Codable {
        var provider_id: Int
        var provider_name: String
        var provider_type: String

       
    }



    // MARK: - AppointmentSlotInfo
    struct AppointmentSlotInfo: Codable {
        var end_time, slot_date, start_time: String

        
}
