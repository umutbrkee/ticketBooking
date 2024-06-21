//
//  ticketSelectionTableViewCell.swift
//  ticketBooking
//
//  Created by Umut on 21.03.2024.
//

import UIKit

class ticketSelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var inceleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var companyImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var flight_id = 0
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(model: DestinationModel) {
        self.companyImage.image = UIImage(named: model.travelModel!.image!)
        self.timeLabel.text = model.travelModel!.time!
        self.priceLabel.text = model.travelModel!.price!
    }
}
