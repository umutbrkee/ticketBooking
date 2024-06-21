//
//  TicketScreenViewController.swift
//  ticketBooking
//
//  Created by Umut on 22.03.2024.
//

import UIKit

class TicketScreenViewController: UIViewController {

    @IBOutlet weak var seatsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        seatsTableView.register(UINib(nibName: "seatsTableViewCell", bundle: nil), forCellReuseIdentifier: "seatsCell")
    }

    @IBAction func CompleteSelection(_ sender: Any) {
           // Seçilen koltukların indekslerini depolamak için bir dizi
           var selectedSeats = Set<Int>()
        
           // TableView'dan koltuk hücrelerini al
           if let cell = seatsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? seatsTableViewCell {
               
               // Her bir koltuğun satış durumunu kontrol et
               for (index, isSold) in cell.seatStatus.enumerated() {
                   // Eğer koltuk satılmışsa ve daha önceden satın alınmamışsa, seçilen koltuklar listesine ekle
                   if isSold && !cell.alreadysold.contains("\(index)") {
                       selectedSeats.insert(index + 1)
                   }
               }
           }

           // UserDefaults'tan daha önce satın alınmış koltukları al
           let key = "reserved_seats_flight_\(TravelListViewController.tappedFlightId!)" // Uygulamaya özgü bir anahtar adı
           var allReservedSeats = Set(UserDefaults.standard.array(forKey: key) as? [Int] ?? [Int]())
           // Seçilen koltukları daha önce satın alınmış koltuklarla birleştir
           allReservedSeats.formUnion(selectedSeats)

           // Birleştirilmiş koltuk listesini UserDefaults'a kaydet
           UserDefaults.standard.set(Array(allReservedSeats), forKey: key)

           // Rezervasyon yapıldıktan sonra kullanıcıya bildirim gösterilebilir veya başka bir işlem yapılabilir
       }
    @IBAction func goBackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension TicketScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "seatsCell") as! seatsTableViewCell
        for (index, label) in cell.seatLabels.enumerated() {
            let tapGesture = UITapGestureRecognizer(target: cell, action: #selector(cell.labelTapped(_:)))
            label.isUserInteractionEnabled = true
            label.tag = index // Etiketin indeksini tag özelliği olarak atayın
            label.addGestureRecognizer(tapGesture)
        }

        return cell
    }
}
