//
//  DateCell.swift
//  ToDoList
//
//  Created by Владимир on 11.01.2022.
//

import UIKit

class DateCell: UITableViewCell {

    @IBOutlet var label: UILabel!
    
    func setDate(_ date: Date) { // функция устанавливает дату
        label.text = date.formattedDate
    }
    
}
