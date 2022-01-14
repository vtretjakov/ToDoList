//
//  ToDoItemTableViewController.swift
//  ToDoList
//
//  Created by Владимир on 06.01.2022.
//

import UIKit

class ToDoItemTableViewController: UITableViewController {
    // MARK: - Properties
    
    var todo = ToDo()
}

// MARK: - UITableViewDataSource

extension ToDoItemTableViewController /*: UITableViewCell */ {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return todo.keys.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let value = todo.values[section]
        return value is Date ? 2 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let value = todo.values[section]
        // нужно получить ячейку определенного типа (через Cell Configurator)
         let cell = getCellFor(indexPath: indexPath, with: value)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let key = todo.capitilizedKeys[section]
        return key
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let value = todo.values[indexPath.section]
        if let cell = tableView.cellForRow(at: indexPath) {
            return cell.isHidden ? 0 : UITableView.automaticDimension
        } else {
            return /* value is Date && indexPath.row == 1 ? 0 : */ UITableView.automaticDimension // для учета случая когда ячейки за пределами tableView, всем ставим automaticDimension кроме случая когда показываем datePicker (тот дэйтпикер что за пределами вью делаем 0
                    
    } // метод для размеров
}
        
    

    // MARK: - UITableViewDelegate
    
   // extension ToDoItemTableViewController /*: уже является UITableViewDelegate  */ {
    
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) /* метод когда человек кликает */ {
            let value = todo.values[indexPath.section]
            
            if value is Date {
                
                // TODO: Implement show/hide date picker(показываем/прячем дэйтпикер)
                
            } else if value is UIImage {
                let alert = UIAlertController(title: "Choose Source", message: nil, preferredStyle: .actionSheet)
                let cancel = UIAlertAction(title: "Cancel", style: .cancel)
                alert.addAction(cancel)
                
                let imagePicker = SectionImagePickerController()
                // создаем для того чтобы установить ему номер секции
                imagePicker.delegate = self
                imagePicker.section = indexPath.section
                
                
                // проверить какие есть источники данных для картинки
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
                        imagePicker.sourceType = .camera
                        self.present(imagePicker, animated: true)
                    }
                    alert.addAction(cameraAction)
                }; if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) {
                        action in imagePicker.sourceType = .photoLibrary
                        self.present(imagePicker, animated: true)
                    }
                    alert.addAction(photoLibraryAction)
            }
                
                present(alert, animated: true)
        }
        }
    

    // MARK: - Cell Configurator
    
    func getCellFor(indexPath: IndexPath, with value: Any?) -> UITableViewCell {
        
        if let stringValue = value as? String {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as! TextFieldCell
            cell.textField.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
            cell.textField.section = indexPath.section
            cell.textField.text = stringValue
            return cell
            
        } else if let dateValue = value as? Date {
            
            switch indexPath.row {
            case 0: // если ячейка нулевая
                let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell") as! DateCell
                cell.setDate(dateValue)
                return cell
            
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell") as! DatePickerCell
                cell.datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
                cell.datePicker.date = dateValue
                cell.datePicker.section = indexPath.section
                cell.datePicker.minimumDate = Date()
                return cell
                
            default:
                fatalError("Please add more prototype cells for Date section") // - не произойдет если никто не будет менять код
            }
            
            
        } else if let imageValue = value as? UIImage {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell
            cell.largeImageView.image = imageValue
            return cell
            
        } else if let boolValue = value as? Bool {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as! SwitchCell
            cell.switch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
            cell.switch.section = indexPath.section
            cell.switch.isOn = boolValue
            return cell
            
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as! TextFieldCell
            cell.textField.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
            cell.textField.section = indexPath.section // номер секции
            cell.textField.text = ""
            return cell
            
        }

    }
    
}

extension ToDoItemTableViewController {
    
    @objc func datePickerValueChanged(_ sender: SectionDatePicker) {
        let section = sender.section! // номер секции
        let key = todo.keys[section] // ключ
        let date = sender.date // значение
        todo.setValue(date, forKey: key) // устанавливаем (изменения сэйвятся)
        // еще необходимо менять значение лэйбла которое отрносится к данному дэйтпикеру
        let labelIndexPath = IndexPath(row: 0, section: section) // дэйт в нулевой ячейке
        tableView.reloadRows(at: [labelIndexPath], with: .automatic) // при изменении дэйтпикера дэйт изменяется соответственно
        
    }
    
    @objc func switchValueChanged(_ sender: SectionSwitch) {
        let key = todo.keys[sender.section!] // получаем имя поля нашего свича
        let value = sender.isOn // значение нашего свича
        todo.setValue(value, forKey: key) // при переключении свича галочка меняется на кружок и наоборот, после нажатия сэйв
        
        
    }
    
    @objc func textFieldValueChanged(_ sender: SectionTextField) {
        // @objc - для того чтобы функция срабатывала в виде таргета, также для срабатывания добавим функцию в getCellFor и где "TextFieldCell" -
      //  print(#function, #line, sender.section) мы видим какое поле редактируется
        // после того как мы узнали номер секции нужно получить ключ секции для этого:
        let key = todo.keys[sender.section!] // !  - извлечь явно потомучто если у нас sectiontextfield  то мы его точно инициализировали если нет то мы хотим эту ошибку поймать как можно раньше
        let text = sender.text ?? "" // может быть опциональный соответственно тогда "" пустая строка
        todo.setValue(text, forKey: key) // setValue функция из NSObject а в качестве value - text key - key,  что позволяет нам в разных секциях установить разные значения(происходит сохранение напечатанного текста после нажатия сэйв)
        
    }
}

extension ToDoItemTableViewController: UIImagePickerControllerDelegate {}
extension ToDoItemTableViewController: UINavigationControllerDelegate{}

