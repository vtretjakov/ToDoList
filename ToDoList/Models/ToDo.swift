//
//  ToDo.swift
//  ToDoList
//
//  Created by Владимир on 06.01.2022.
//

import UIKit

class ToDo {
    var title: String
    var isComplete: Bool // выполнилось или нет
    var dueData: Date // дата окончания
    var notes: String? // заметки опциональные
    var image: UIImage?
    
    // т.к класс, у нас нет стандартного инициализатора (конструктора):
    
    init (
     title: String = "",
     isComplete: Bool = false,
     dueData: Date = Date(),
     notes: String? = nil,
     image: UIImage? = nil
    ) {
     self.title = title
     self.isComplete = isComplete
     self.dueData = dueData
     self.notes = notes
     self.image = image
    }
}
