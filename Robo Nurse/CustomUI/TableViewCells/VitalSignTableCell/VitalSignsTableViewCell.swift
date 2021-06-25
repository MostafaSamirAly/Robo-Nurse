//
//  VitalSignsTableViewCell.swift
//  Robo Nurse
//
//  Created by Mac Store Egypt on 21/05/2021.
//  Copyright © 2021 Mostafa Samir. All rights reserved.
//

import UIKit

class VitalSignsTableViewCell: UITableViewCell {
    @IBOutlet var labels: [UILabel]!
    @IBOutlet weak var subview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        subview.layer.cornerRadius = 10
        subview.clipsToBounds = true
    }
    
    func setup(with reading:Readings) {
        labels[0].text = reading.date
        labels[1].text = reading.time
        labels[2].text = reading.temp.description
        labels[3].text = reading.oxygen.description
        labels[4].text = reading.ppm.description
    }
    
}
