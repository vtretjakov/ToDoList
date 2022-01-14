//
//  String+Extension.swift
//  ToDoList
//
//  Created by Владимир on 08.01.2022.
//

extension String {
    
    var capitilizedWithSpaces: String {
        let withSpaces = reduce("") { result, character in
            character.isUppercase ? "\(result) \(character)" : "\(result)\(character)"
            
        }
        return withSpaces.capitalized
    }
    
}

// свойство для наших стрингов 
