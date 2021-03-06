//
//  CreateCardViewController.swift
//  cardMaker
//
//  Created by Seantastic31 on 09/08/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

import UIKit
import os.log
import ImagePicker

// rename this class

class CreateCardViewController: UIViewController, UITextFieldDelegate, ImagePickerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    // MARK: Card Detail View Properties
    @IBOutlet weak var teamTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var basePhoto: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: Frame CollectionView & Frame for mainDisplay
    @IBOutlet weak var frameCollectionView: UICollectionView!
    @IBOutlet weak var frameImage: UIImageView!
    
    // MARK: View from which png snapshot will be created
    @IBOutlet weak var pngView: UIView!
    
    
    // MARK: basePhoto properties for gesture recognizer
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    
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
        
        //MARK: Frame Collection Data
        seedData = SeedData()
        
        updateSaveButtonState()
    }
    

    
    // MARK: Calculate Zoom Scale for baseImage
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = scrollView.frame.size.width / basePhoto.bounds.width
        let heightScale = scrollView.frame.height / basePhoto.bounds.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    
    

    @IBAction func cameraButtonTapped(_ sender: Any) {
        var config = Configuration()
        config.doneButtonTitle = "Finish"
        config.noImagesTitle = "Sorry! There are no images here!"
        config.recordLocation = false
        //config.allowVideoSelection = true
        
        let imagePicker = ImagePickerController()
        imagePicker.configuration = config
        imagePicker.delegate = self
        imagePicker.imageLimit = 1
        
        present(imagePicker, animated: true, completion: nil)
    }

    
    // MARK: - ImagePickerDelegate
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else { return }
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
        guard images.count > 0 else { return }

        basePhoto.image = images[0]
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

    // MARK: Prepare for segue & save data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // This prevents default text from being printed on a card
        if (teamTextField.text?.isEmpty)! { teamTextField.text = " " }
        if (nameTextField.text?.isEmpty)! { nameTextField.text = " " }

        if (self.card != nil) {
            self.card?.team = teamTextField.text ?? ""
            self.card?.name = nameTextField.text ?? ""
            self.card?.photo = basePhoto.image
            self.card?.frame = frameImage.image
            self.card?.pngImage = UIImage.init(view: pngView)
        } else {
        let team = teamTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let photo = basePhoto.image
        let frame = frameImage.image
        let pngImage = UIImage.init(view: pngView)


        card = Card(team: team, name: name, photo: photo, frame: frame, pngImage: pngImage)
        }
        
        if segue.identifier == "backCardEntry" {
            let backCardVC = segue.destination as! BackViewController
            backCardVC.card = self.card!
        }
        
//        super.prepare(for: segue, sender: sender)

        
    }
    
    
    
    
    
    
    
    

    //MARK: Private Methods
    private func updateSaveButtonState() {
        //        Disable the Save button if any of the texts fields are empty
//        let teamText = teamTextField.text ?? ""
//        let nameText = nameTextField.text ?? ""
        saveButton.isEnabled = true
    }

    
}


//MARK: PhotoZoom Extension for basePhoto
extension CreateCardViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return basePhoto
    }
    
//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        updateConstraintsForSize(view.bounds.size)
//    }
//    
//    fileprivate func updateConstraintsForSize(_ size: CGSize) {
//        
//        let yOffset = max(0, (size.height - basePhoto.frame.height) / 2 - 100)
//        imageViewTopConstraint.constant = yOffset
//        imageViewBottomConstraint.constant = yOffset
//        
//        let xOffset = max(0, (size.width - basePhoto.frame.width) / 2)
//        imageViewLeadingConstraint.constant = xOffset
//        imageViewTrailingConstraint.constant = xOffset
//        
//        view.layoutIfNeeded()
//    }

    

}
