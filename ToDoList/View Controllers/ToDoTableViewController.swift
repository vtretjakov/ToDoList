//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Владимир on 06.01.2022.
//

import UIKit

class ToDoTableViewController: UITableViewController {

    var todos = [ToDo]()
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        todos = [
            ToDo(title: "Купить воду", image: UIImage(named: "water")),
            ToDo(title: "Записаться на персональную тренеровку", image: UIImage(named: "sport")),
            ToDo(title: "Сдать урок английского", image: UIImage(named: "english")),
        ]
    }
    
    //MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        let todo = todos[indexPath.row]
        configure(cell, with: todo)
        return cell
    }
    
    // MARK: - Cell Content
    func configure(_ cell: UITableViewCell, with todo: ToDo) {
        // cell.textLabel?.text = todo.title
        // cell.detailTextLabel?.text = todo.isComplete ? "☑️" : "⚪️"
        // cell.imageView?.image = todo.image    - традиционный подход
        
        
    }
    
}
