//
//  Ticket.swift
//  ticketBooking
//
//  Created by Umut on 20.03.2024.


import Foundation

class Ticket {
    var yolcu: Yolcu
    var tarih: Tarih
    var saat: Saat
    var to: String
    var from: String
    var price: String
    var seatCount: Int
    var seatNum: [String]


    func karsilastir(){
    }
    func koltukAyir(seatCount: Int) -> Bool {
        return UserDefaults.standard.bool(forKey: "selectedSeatNumber")
  
    }
    func koltukNoEkle(){
    }
    func yazdir(){
    }
    
    init(passengerName:String,date:String,time:String,to:String,from:String,price:String,seatCount:Int, seatNum:String){
        self.yolcu = Yolcu(passengerName: passengerName)
        self.tarih = Tarih(date: date)
        self.saat = Saat(time: time)
        self.to = to
        self.from = from
        self.price = price
        self.seatCount = seatCount
        self.seatNum = []
    }
}
