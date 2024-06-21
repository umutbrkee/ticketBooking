
import UIKit
import iOSDropDown

class firstViewController: UIViewController {
    
    @IBOutlet weak var fromLabel: DropDown!
    @IBOutlet weak var toLabel: DropDown!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var switchTextButton: UIButton!
    
    var date:String = ""
    
    
    static var newTicket = Ticket(passengerName: "", date: "", time: "", to: "", from: "", price: "", seatCount: 0, seatNum: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let option =  Options()
        fromLabel.optionArray = option.cities
        toLabel.optionArray = option.cities
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        date = dateFormatter.string(from: Date())
        
        let onboardCheck = UserDefaults.standard.bool(forKey: "Onboarded")
        if(!onboardCheck){
            UserDefaults.standard.set(true, forKey: "Onboarded")
            //self.onStart()
        }
    }

    // TODO: Onboarding Screen`e Yonlendir
    /*
     func onStart () {
     let onboardingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "onboardingIdentity") as! OnboardingViewController
     onboardingVC.modalPresentationStyle = .fullScreen
     present(onboardingVC, animated: true, completion: nil)
     }
     */
    @IBAction func datePickerVal(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        // DatePicker'dan alınan tarih ve saat bilgisini yerel saat dilimine dönüştür
        let localDate = datePicker.date
        dateFormatter.timeZone = TimeZone.current
        
        // Yerel saat dilimine dönüştürülen tarihi biçimlendir
        date = dateFormatter.string(from: localDate)
    }
    
    @IBAction func searchBtnAction(_ sender: Any) {
        guard let from = fromLabel.text else { return }
        guard let to = toLabel.text else { return }
        var alertMessage = ""
        var alert = false
        if(from == "" || to == ""){
            alertMessage = "Please Select Cities"
            alert = true
        } else if (from == to){
            alertMessage = "Selected Cities Can Not Be Same"
            alert = true
        }
        if alert {
            let alertController = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
                //ozellik eklenebilir labellari sifirlama vs
            }
            alertController.addAction(action)
            present(alertController, animated: true)
        } else {
            // Eğer herhangi bir hata yoksa, diğer işlemlere devam et
            let sendVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TravelListIdentity") as! TravelListViewController
            sendVC.destination1 = from
            sendVC.destination2 = to
            sendVC.date = date
            sendVC.modalPresentationStyle = .fullScreen
            sendVC.modalTransitionStyle = .coverVertical
            
            firstViewController.newTicket.from = from
            firstViewController.newTicket.to = to
            firstViewController.newTicket.tarih.date = date
            
            present(sendVC, animated: true, completion: nil)
        }
    }
}

