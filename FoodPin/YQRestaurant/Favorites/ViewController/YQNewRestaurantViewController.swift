//
//  YQNewRestaurantViewController.swift
//  FoodPin
//
//  Created by yoferzhang on 2018/12/14.
//  Copyright © 2018 yoferzhang. All rights reserved.
//

import UIKit
import CloudKit

class YQNewRestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var restaurant: RestaurantMO!
    var editTableView: UITableView!
    var photoImageView: UIImageView!
    var imageData: Data!
    
    var nameTextField: UITextField!
    var typeTextField: UITextField!
    var addressTextField: UITextField!
    var photoTextField: UITextField!
    var descriptionTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureNav()
        
        initData()
        initViews()
        // Do any additional setup after loading the view.
    }
    
    func configureNav() {
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "New Restaurant"
        
        navigationController?.navigationBar.tintColor = UIColor.orange
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.orange, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 35.0)
        ]
        
        let rightItem = UIBarButtonItem(image: UIImage(named: "save"), style: .plain, target: self, action: #selector(onClickNavRightButton))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func initData() {
        restaurant = RestaurantMO()
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
            photoImageView = cell.photoImageView
            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YQRestaurantEditInfoCell.self), for: indexPath) as! YQRestaurantEditInfoCell
            cell.configure(title: "NAME", placeholder: "Fill in the restaurant name")
            cell.textField.becomeFirstResponder()
            cell.textField.tag = 1
            cell.textField.delegate = self
            nameTextField = cell.textField
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YQRestaurantEditInfoCell.self), for: indexPath) as! YQRestaurantEditInfoCell
            cell.configure(title: "TYPE", placeholder: "Fill in the restaurant type")
            cell.textField.tag = 2
            cell.textField.delegate = self
            typeTextField = cell.textField
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YQRestaurantEditInfoCell.self), for: indexPath) as! YQRestaurantEditInfoCell
            cell.configure(title: "ADDRESS", placeholder: "Fill in the restaurant address")
            cell.textField.tag = 3
            cell.textField.delegate = self
            addressTextField = cell.textField
            cell.selectionStyle = .none
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YQRestaurantEditInfoCell.self), for: indexPath) as! YQRestaurantEditInfoCell
            cell.configure(title: "PHONE", placeholder: "Fill in the restaurant phone")
            cell.textField.tag = 4
            cell.textField.delegate = self
            photoTextField = cell.textField
            cell.selectionStyle = .none
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YQRestaurantEditInfoCell.self), for: indexPath) as! YQRestaurantEditInfoCell
            cell.configure(title: "DESCRIPTION", placeholder: "Fill in the restaurant description")
            cell.textField.tag = 5
            cell.textField.delegate = self
            descriptionTextField = cell.textField
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
                    imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            }
            
            let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    
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
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView?.image = selectedImage
            photoImageView?.contentMode = .scaleAspectFill
            photoImageView?.clipsToBounds = true
            imageData = selectedImage.pngData()
        }
        
        dismiss(animated: true, completion: nil)
    }

    //MARK: - 点击事件
    @objc func onClickNavRightButton(recognizer: UITapGestureRecognizer) {
        if nameTextField.text!.count <= 0 || typeTextField.text!.count <= 0 || addressTextField.text!.count <= 0 || photoTextField.text!.count <= 0 || descriptionTextField.text!.count <= 0 || imageData == nil {
            
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            let alertViewController = UIAlertController(title: "Oops", message: "We can't proceed because ont of the fields is blank. Please note that all fields are required.", preferredStyle: .alert)
            
            alertViewController.addAction(okAction)
            
            present(alertViewController, animated: true, completion: nil)
        } else {
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                restaurant = RestaurantMO(context: appDelegate.persistentContainer.viewContext)
                restaurant.name = nameTextField.text
                restaurant.type = typeTextField.text
                restaurant.location = addressTextField.text
                restaurant.phone = photoTextField.text
                restaurant.summary = descriptionTextField.text
                restaurant.isVisited = false
                restaurant.image = imageData
                restaurant.rating = ""
                
                print("Saving new data to context")
                appDelegate.saveContext()
                
                saveRecordToCloud(restaurant: restaurant)
                
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
    
    func saveRecordToCloud(restaurant: RestaurantMO!) -> Void {
        // Prepare the record to save
        let record = CKRecord(recordType: "Restaurant")
        record.setValue(restaurant.name, forKey: "name")
        record.setValue(restaurant.type, forKey: "type")
        record.setValue(restaurant.location, forKey: "location")
        record.setValue(restaurant.phone, forKey: "phone")
        record.setValue(restaurant.summary, forKey: "description")
        
        let imageData = restaurant.image! as Data
        
        // Resize the image
        let originalImage = UIImage(data: imageData)!
        let scalingFactor = (originalImage.size.width > 1024) ? 1024 / originalImage.size.width : 1.0
        let scaledImage = UIImage(data: imageData, scale: scalingFactor)
        
        // Write the image to local file for temporary use
        let imageFilePath = NSTemporaryDirectory() + restaurant.name!
        let imageFileURL = URL(fileURLWithPath: imageFilePath)
        try? scaledImage?.jpegData(compressionQuality: 0.8)?.write(to: imageFileURL)
        
        // Create image asset for upload
        let imageAsset = CKAsset(fileURL: imageFileURL)
        record.setValue(imageAsset, forKey: "image")
        
        // Get the Public iCloud Database
        let publicDatabase = CKContainer.default().publicCloudDatabase
        
        // Save the record to iCloud
        publicDatabase.save(record, completionHandler: { (record, error) -> Void in
            // Remove temp file
            try? FileManager.default.removeItem(at: imageFileURL)
        })
    }
}
