//
//  CardViewController.swift
//  cardMaker
//
//  Created by Seantastic31 on 09/08/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

import UIKit
import os.log

class CardViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    // MARK: Card Detail View Properties
    @IBOutlet weak var teamTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var basePhoto: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: Frame CollectionView Properties
    @IBOutlet weak var frameCollectionView: UICollectionView!
    
    // MARL: Add frame image to large view
    @IBOutlet weak var frameImage: UIImageView!
    
    @IBOutlet weak var pngView: UIView!
    //MARK Generate Frame Data
    var seedData: SeedData!
    
    
    var card: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamTextField.delegate = self
        nameTextField.delegate = self
        
        if let card = card {
            navigationItem.title = card.name
            teamTextField.text = card.team
            nameTextField.text = card.name
            basePhoto.image = card.photo
        }
        
        //MARK Frame Collection Data
        seedData = SeedData()
        
        
        
        updateSaveButtonState()
    }
    
    // MARK: Frame CollectionView Data Source
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seedData.frames.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"Cell", for: indexPath)
        if let frameCell = cell as? FrameCollectionViewCell {
            frameCell.frameCellImage.image
                = seedData.frames[indexPath.row].frameImage
            frameCell.backgroundView = UIImageView(image: card?.photo)
            return frameCell
            
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        frameImage.image = seedData.frames[indexPath.row].frameImage
        card?.frame = frameImage.image
        
    }
    
    
    
    
    
    
    
    
    // MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    //MARK: UIImagePickerControllerdelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as?
            UIImage else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info) ")
        }
        basePhoto.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        let isPresentingInAddMealMode = presentingViewController is
        UINavigationController
        
        if isPresentingInAddMealMode {
            
            dismiss(animated: true, completion: nil)
        }
            
        else if let owningNavigationController = navigationController {
            
            owningNavigationController.popViewController(animated: true)
        }
            
        else {
            
            fatalError("The CardViewController is not inside a navigation controller")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let team = teamTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let photo = basePhoto.image
        let frame = frameImage.image
//        let pngImage = pngView.asImage()
        let pngImage = UIImage.init(view: pngView)
        
        card = Card(team: team, name: name, photo: photo, frame: frame, pngImage: pngImage)
        
        
    }
    
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        teamTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    
    
    
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        //        Disable the Save button if any of the texts fields are empty
        let teamText = teamTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        saveButton.isEnabled = !teamText.isEmpty && !nameText.isEmpty
    }
}