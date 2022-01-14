//
//  ToDo.swift
//  ToDoList
//
//  Created by Владимир on 06.01.2022.
//

import UIKit

@objcMembers class ToDo: NSObject { // objc для всех внутри класса ( более гибкий и используется всегда когда мы хотим изменять свойство объекта )
    var title: String
    var isComplete: Bool // выполнилось или нет
    var dueDate: Date // дата окончания
    var notes: String? // заметки опциональные
    var image: UIImage?
    
    // т.к класс, у нас нет стандартного инициализатора (конструктора):
    
    init (
     title: String = "",
     isComplete: Bool = false,
     dueDate: Date = Date(),
     notes: String? = nil,
     image: UIImage? = nil
    ) {
     self.title = title
     self.isComplete = isComplete
     self.dueDate = dueDate
     self.notes = notes
     self.image = image
    }
    
    var capitilizedKeys: [String] {
        return keys.map {$0.capitilizedWithSpaces}
    }
    
    var keys: [String] {
        return Mirror(reflecting: self).children.compactMap{ $0.label } // children это и есть наши свойства но нам нужно преобразовать в массив строк $0 - каждый элемент
    }
    
    var values: [Any?] {
        return Mirror(reflecting: self).children.map {$0.value}
    }
    
    override func copy() -> Any {
        
        let newToDo = ToDo(
            title: title,
            isComplete: isComplete,
            dueDate: dueDate,
            notes: notes,
            image: image?.copy() as? UIImage
        )
        return newToDo
    }
    
}
