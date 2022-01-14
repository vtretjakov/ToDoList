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
            ToDo(title: "Записаться на тренеровку", image: UIImage(named: "sport")),
            ToDo(title: "Сдать урок английского", image: UIImage(named: "english")),
        ]
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell // конвертация в todocell
        let todo = todos[indexPath.row]
        configure(cell, with: todo)
        return cell
    }
    
    // MARK: - Cell Content
    func configure(_ cell: ToDoCell, with todo: ToDo) {
        // cell.textLabel?.text = todo.title
        // cell.detailTextLabel?.text = todo.isComplete ? "☑️" : "⚪️"
        // cell.imageView?.image = todo.image    - традиционный подход (без todocell cell: UITableViewCell)
        guard let stackView = cell.stackView else {return}
        guard stackView.arrangedSubviews.count == 0 else {return}
        
        for index in 0 ..< todo.keys.count {
            let key = todo.capitilizedKeys[index]
            let value = todo.values[index]
            
            if let stringValue = value as? String {
                
                let label = UILabel()
                label.text = "\(key): \(stringValue)"
                stackView.addArrangedSubview(label)
                
            } else if let dateValue = value as? Date {
                
                let label = UILabel()
                label.text = "\(key): \(dateValue.formattedDate)"
                stackView.addArrangedSubview(label)
                
            } else if let boolValue = value as? Bool {
                
                let label = UILabel()
                label.text = "\(key): \(boolValue ? "☑️" : "⚪️")"
                stackView.addArrangedSubview(label)
                
            } else if let imageValue = value as? UIImage {
                
                let imageView = UIImageView(image: imageValue)
                let heightConstrain = NSLayoutConstraint(
                    item: imageView,
                    attribute: .height,
                    relatedBy: .equal,
                    toItem: nil,
                    attribute: .height,
                    multiplier: 1,
                    constant: 200
                )
                imageView.addConstraint(heightConstrain)
                imageView.contentMode = .scaleAspectFit
                stackView.addArrangedSubview(imageView)
                
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ToDoItemSegue" else {return}
        guard let selectedIndex = tableView.indexPathForSelectedRow else {return}
        let destination = segue.destination as! ToDoItemTableViewController
        destination.todo = todos[selectedIndex.row].copy() as! ToDo
    }
    
    @IBAction func unwind (_ segue: UIStoryboardSegue) {
        
        guard segue.identifier == "SaveSegue" else {return}
        guard let selectedIndex = tableView.indexPathForSelectedRow else {return}
        let source = segue.source as! ToDoItemTableViewController
        todos[selectedIndex.row] = source.todo
        
        if let toDoCell = tableView.cellForRow(at: selectedIndex) as? ToDoCell {
            if let stackView = toDoCell.stackView {
                stackView.arrangedSubviews.forEach { subview in stackView.removeArrangedSubview(subview)
                    subview.removeFromSuperview()
            }
          }
        }
        tableView.reloadRows(at: [selectedIndex], with: .automatic)
    }
    
}
