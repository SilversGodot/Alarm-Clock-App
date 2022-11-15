//
//  AlarmTableViewCell.swift
//  Alarm Clock
//
//  Created by User1 on 11/14/22.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {

    @IBOutlet weak var alarmCellLabel: UILabel!
    @IBOutlet weak var alarmCellSwitch: UISwitch!
    
    public static var id = "alarmCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func switchChange(_ sender: UISwitch) {

    }
    
    public static func nib() -> UINib {
        return UINib(nibName: "AlarmTableViewCell", bundle: nil)
    }
}
