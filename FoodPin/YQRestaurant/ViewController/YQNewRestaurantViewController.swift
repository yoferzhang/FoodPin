//
//  YQNewRestaurantViewController.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/12/14.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

import UIKit

class YQNewRestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var editTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "New Restaurant"
        
        navigationController?.navigationBar.tintColor = UIColor.orange
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.orange, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 35.0)
        ]
        
        
        
        initViews()
        // Do any additional setup after loading the view.
    }
    
    func initViews() {
        editTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        editTableView.delegate = self
        editTableView.dataSource = self
        editTableView.separatorStyle = .none
        editTableView.register(YQRestaurantEditInfoCell.self, forCellReuseIdentifier: String(describing: YQRestaurantEditInfoCell.self))
        editTableView.register(YQRestaurantEditPhotoCell.self, forCellReuseIdentifier: String(describing: YQRestaurantEditPhotoCell.self))

        view.addSubview(editTableView)
        
    }
    

    // MARK: - tableViewDelegate & tableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YQRestaurantEditPhotoCell.self), for: indexPath) as! YQRestaurantEditPhotoCell
            cell.selectionStyle = .none
            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YQRestaurantEditInfoCell.self), for: indexPath) as! YQRestaurantEditInfoCell
            cell.configure(title: "NAME", placeholder: "Fill in the restaurant name")
            cell.textField.becomeFirstResponder()
            cell.textField.tag = 1
            cell.textField.delegate = self
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YQRestaurantEditInfoCell.self), for: indexPath) as! YQRestaurantEditInfoCell
            cell.configure(title: "TYPE", placeholder: "Fill in the restaurant type")
            cell.textField.tag = 2
            cell.textField.delegate = self
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YQRestaurantEditInfoCell.self), for: indexPath) as! YQRestaurantEditInfoCell
            cell.configure(title: "ADDRESS", placeholder: "Fill in the restaurant address")
            cell.textField.tag = 3
            cell.textField.delegate = self
            cell.selectionStyle = .none
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YQRestaurantEditInfoCell.self), for: indexPath) as! YQRestaurantEditInfoCell
            cell.configure(title: "PHONE", placeholder: "Fill in the restaurant phone")
            cell.textField.tag = 4
            cell.textField.delegate = self
            cell.selectionStyle = .none
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YQRestaurantEditInfoCell.self), for: indexPath) as! YQRestaurantEditInfoCell
            cell.configure(title: "DESCRIPTION", placeholder: "Fill in the restaurant description")
            cell.textField.tag = 5
            cell.textField.delegate = self
            cell.selectionStyle = .none
            return cell
            
        default:
            fatalError("Failed to instantiate the table view cell for detail view controoler")
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return EditPhotoCellConstants.heightOfEditPhotoCell
        case 1, 2, 3, 4:
            return 88
        case 5:
            return 125

        default:
            fatalError("Failed to instantiate the table view cell for detail view controoler")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            }
            
            let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            }
            
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            
            present(photoSourceRequestController, animated: true, completion: nil)
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        
        return true
    }

}
