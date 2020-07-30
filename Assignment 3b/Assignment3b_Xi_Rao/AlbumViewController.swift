//
//  AuburnViewController.swift
//  Assignment3b_Xi_Rao
//
//  Created by Xi Rao on 7/29/20.
//  Copyright © 2020 Xi Rao. All rights reserved.
//

import UIKit
import os.log

class AlbumViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var albumCover: UIImageView!

    @IBOutlet weak var albumLabel: UITextField!
    @IBOutlet weak var artistLabel: UITextField!
    @IBOutlet weak var releasedYear: UITextField!
    @IBOutlet weak var recordLabel: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var album: Album?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        albumLabel.delegate = self
        artistLabel.delegate = self
        
        if let album = album {
            navigationItem.title = album.title
            albumLabel.text = album.title
            artistLabel.text = album.artist
            albumCover.image = album.cover
            releasedYear.text = album.releasedYear
            recordLabel.text = album.recordLabel
        }
        
        updateSaveButtonState()

    }

    //MARK: Private Methods
    private func updateSaveButtonState() {
        let text = albumLabel.text ?? ""
        let text2 = artistLabel.text ?? ""
        saveButton.isEnabled = !text.isEmpty && !text2.isEmpty
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        albumCover.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The AlbumViewController is not inside a navigation controller.")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let title = albumLabel.text
        let cover = albumCover.image
        let artist = artistLabel.text
        let year = releasedYear.text ?? ""
        let record = recordLabel.text ?? ""
        
        album = Album(title: title!, cover: cover, artist: artist!, releasedYear: year, recordLabel: record)
    }
    
    //MARK: Actions
    @IBAction func selectCoverFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        //Hide the keyboard
        albumLabel.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
}

