//
//  TravelListViewController.swift
//  ticketBooking
//
//  Created by Umut on 21.03.2024.
//

import UIKit

class TravelListViewController: UIViewController {
    @IBOutlet weak var travelListTableView: UITableView!
    @IBOutlet var goBackButton: UIButton!
    
    var destinations = [DestinationModel]()
    var destination1: String = ""
    var destination2: String = ""
    var date: String = ""
    var travels = [TravelModel]()
    static var tappedFlightId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        travelListTableView.register(UINib(nibName: "ticketSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "travelCellTest")
        loadDataFromJson()
    }
    

    @IBAction func goBackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension TravelListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "travelCellTest") as! ticketSelectionTableViewCell
        cell.configure(model: destinations[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        firstViewController.newTicket.saat.time = destinations[indexPath.row].travelModel?.time! ?? "-"
        firstViewController.newTicket.price = destinations[indexPath.row].travelModel?.price! ?? "-"
        if let selectedFlightId = destinations[indexPath.row].flight_id {
            let seatScreenVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "seatScreenID") as! TicketScreenViewController
            seatScreenVC.modalPresentationStyle = .fullScreen
            seatScreenVC.modalTransitionStyle = .flipHorizontal
            TravelListViewController.tappedFlightId = selectedFlightId // TicketScreenViewController'daki değişkene flight id'yi aktar
            present(seatScreenVC, animated: true, completion: nil)
        }
    }
    private func loadDataFromJson() {
        // JSON dosyasının yolunu al
        if let path = Bundle.main.path(forResource: "travels", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                // JSON verilerini çöz
                let decoder = JSONDecoder()
                var destinationData = try decoder.decode([DestinationModel].self, from: data)
                // Kullanıcının seçtiği şehirlere ve tarihe göre uygun uçuşları filtrele
                destinationData = destinationData.filter { destination in
                    return destination.destination1 == destination1 &&
                        destination.destination2 == destination2 &&
                        destination.date == date
                }
                // Filtrelenmiş uçuşları hedeflere ekle
                destinations = destinationData
                // UserDefaults'ta koltuk dolu numaralarını sakla
                for destination in destinations {
                    var soldSeatNumbers = destination.soldSeatNumbers ?? ["2", "3"] // soldSeatNumbers nil ise bu koltuklari kullan
                    if let flightId = destination.flight_id {
                        let key = "flight_\(flightId)" // Flight id'yi kullanarak key oluştur
                        UserDefaults.standard.set(soldSeatNumbers, forKey: key)
                    }
                }
                if destinations.isEmpty {
                    //Ucus yoksa alert basip geri gotur
                    let alertController2 = UIAlertController(title: "Alert", message: "There are no flights available for the selected cities and date.", preferredStyle: .alert)
                    let action2 = UIAlertAction(title: "OK", style: .default) { (action) in
                        self.dismiss(animated: true, completion: nil)
                    }
                    alertController2.addAction(action2)
                    present(alertController2, animated: true)
                    // TODO: CALISMIYOR KONTROL ET
                }
            } catch {
                print("Error reading JSON file:", error.localizedDescription)
            }
        }
    }
}
