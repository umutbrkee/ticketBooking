//
//  destination.swift
//  ticketBooking
//
//  Created by Umut on 21.03.2024.
//

import UIKit

struct DestinationModel: Decodable{
    var flight_id: Int? // Uçuş ID'si
    var destination1: String?
    var destination2: String?
    var date: String?
    var travelModel: TravelModel?
    var soldSeatNumbers: [String]?
}
