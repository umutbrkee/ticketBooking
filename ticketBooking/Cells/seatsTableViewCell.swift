//  ticketBooking
//
//  Created by Umut on 21.03.2024.
//

import UIKit

class seatsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var label8: UILabel!
    @IBOutlet weak var label9: UILabel!
    @IBOutlet weak var label10: UILabel!
    @IBOutlet weak var label11: UILabel!
    @IBOutlet weak var label12: UILabel!
    @IBOutlet weak var label13: UILabel!
    @IBOutlet weak var label14: UILabel!
    @IBOutlet weak var label15: UILabel!
    @IBOutlet weak var label16: UILabel!
    @IBOutlet weak var label17: UILabel!
    @IBOutlet weak var label18: UILabel!
    @IBOutlet weak var label19: UILabel!
    @IBOutlet weak var label20: UILabel!
    
    var seatLabels: [UILabel] {
        return [label1, label2, label3, label4, label5, label6, label7, label8, label9, label10, label11, label12, label13, label14, label15, label16, label17, label18, label19, label20]
    }
    var TicketScreenViewController: firstViewController?
    // Her koltuğun satış durumunu tutacak olan boolean dizisi
    var seatStatus: [Bool] = Array(repeating: false, count: 20)
    var alreadysold = [String]()
    public var selecteddFlightId: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabels()
        mainStackView.layer.cornerRadius = 5
        mainStackView.layer.borderWidth = 1
        mainStackView.layer.borderColor = CGColor(red: 0, green: 34, blue: 77, alpha: 0.5)

        setupReserved()
    }
    
    func setupLabels() {
        for (index, label) in seatLabels.enumerated() {
            label.text = "\(index + 1)"
            label.layer.cornerRadius = 5
            label.layer.borderWidth = 1
            label.textColor = UIColor.blue
            label.layer.borderColor = UIColor.blue.cgColor
            let key = "flight_\(TravelListViewController.tappedFlightId!)"

            if let soldSeatNumbers = UserDefaults.standard.array(forKey: key) as? [String] {
                // Eğer soldSeatNumbers listesinde ilgili etiketin numarası varsa, etiketin rengini kırmızı yap
                if soldSeatNumbers.contains("\(index + 1)") {
                    label.text = "sold"
                    label.textColor = UIColor.red
                    label.layer.borderColor = UIColor.red.cgColor
                    alreadysold.append("\(index)")
                }
            } else {
            }

            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(tapGesture)
        }
    }
    func setupReserved() {
        for (index, label) in seatLabels.enumerated() {

            let reservedKey = "reserved_seats_flight_\(TravelListViewController.tappedFlightId!)"
            
            if let reservedSeatsArray = UserDefaults.standard.array(forKey: reservedKey) as? [Int] {
                // Eğer allReservedSeats listesinde ilgili etiketin numarası varsa, etiketin rengini mavi yap
                if reservedSeatsArray.contains(index + 1) {
                    label.textColor = UIColor.red
                    label.text = "occupied"
                    label.layer.borderColor = UIColor.blue.cgColor
                }
            } else {
                // Hata olusursa buraya gelir handler alert vs koyulabilir
            }
        }
    }
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        let key = "reserved_seats_flight_\(TravelListViewController.tappedFlightId!)" // Uygulamaya özgü bir anahtar adı
        var allReservedSeats = Set(UserDefaults.standard.array(forKey: key) as? [Int] ?? [])
        if let label = sender.view as? UILabel, let index = seatLabels.firstIndex(of: label) {
            // Eğer koltuk zaten satılmışsa, hiçbir işlem yapmadan fonksiyondan çık
            if alreadysold.contains("\(index)") {
                return
            }
            
            // Eğer seçilen koltuk zaten satılmışsa, seçimi iptal et ve fonksiyondan çık
            if seatStatus[index] {
                seatStatus[index] = false
                alreadysold.removeAll { $0 == "\(seatStatus[index])" }
                
                
                // Koltukları seçilenler listesinden kaldır
                
                allReservedSeats.remove(index + 1)

                // Güncellenmiş koltuk listesini UserDefaults'a kaydet
                UserDefaults.standard.set(Array(allReservedSeats), forKey: key)
                
                label.textColor = UIColor.blue
                label.layer.borderColor = UIColor.blue.cgColor
                label.text = "\(index + 1)"
                return
            }
            
            // Koltuğun satış durumunu toggle et
            seatStatus[index].toggle()
            allReservedSeats.insert(index + 1)

            // Etiketin rengini güncelle
            label.textColor = seatStatus[index] ? UIColor.red : UIColor.blue
            label.text = seatStatus[index] ? "occupied" : "\(index + 1)"
            label.layer.borderColor = UIColor.blue.cgColor
            
            // Seçilen koltukları daha önce satın alınmış koltuklarla birleştir

            // Birleştirilmiş koltuk listesini UserDefaults'a kaydet
            UserDefaults.standard.set(Array(allReservedSeats), forKey: key)
            
        }
    }
}
