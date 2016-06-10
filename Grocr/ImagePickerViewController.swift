//
//  ImagePickerViewController.swift
//  Grocr
//
//  Created by Thomas Bloss on 5/16/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//


import UIKit

class ImagePickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var ref = GroceryListTableViewController.Reference.ref
    var imageContainer: UIImage?
    var extraRef = GroceryListTableViewController.Reference.extraRef
    let imagePicker = UIImagePickerController()
    var imagePicked: Bool = false
    
//    @IBAction func saveImageUp(sender: AnyObject) {
//        if let image = imageView.image {
//            let imageData = UIImageJPEGRepresentation(image, 0.2)
//            let base64String = imageData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
//            print(base64String)
//            let imageRef = ref.childByAppendingPath("image_path")
//
//            imageRef.setValue(base64String)
//            
////            imageRef.observeEventType(.Value, withBlock: { snapshot in
////                
////                let base64EncodedString = snapshot.value
////                let imageData = NSData(base64EncodedString: base64EncodedString as! String,
////                    options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
////                let decodedImage = UIImage(data:imageData!)
////                self.imageView2.image = decodedImage
////                
////                }, withCancelBlock: { error in
////                    print(error.description)
////            })
//
//        }
//        
//    }
    
//
//    @IBAction func LoadImageUp(sender: AnyObject) {
//        let imageRef = ref.childByAppendingPath("image_path")
//
//        imageRef.observeEventType(.Value, withBlock: { snapshot in
//            
//            let base64EncodedString = snapshot.value
//            let imageData = NSData(base64EncodedString: base64EncodedString as! String,
//                options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
//            let decodedImage = UIImage(data:imageData!)
//            self.imageView2.image = decodedImage
//            
//            }, withCancelBlock: { error in
//                print(error.description)
//        })
//        
//    }
  func loadImageButtonTapped() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
//        imagePicker.allowsEditing = false
//        imagePicker.sourceType = .PhotoLibrary
//        
//        presentViewController(imagePicker, animated: true, completion: nil)
//        
//        imagePicker
    
    }
    
    override func viewWillAppear(animated: Bool) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        if imagePicked == false {
        presentViewController(imagePicker, animated: true, completion: nil)
        } else {
            performSegueWithIdentifier("goBack", sender: nil)

        }
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageContainer = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        // EncodeImage and set value in Reference
        if let image = imageContainer {
            let imageData = UIImageJPEGRepresentation(image, 0.2)
            let base64String = imageData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
//            print(base64String)
            let imageRef = GroceryListTableViewController.Reference.ref.childByAppendingPath("image")
            
            imageRef.setValue(base64String)
            imagePicked = true
//            performSegueWithIdentifier("goBack", sender: nil)

        }
        
        //Decode Image
//        let imageRef = ref.childByAppendingPath("image")
//        
//        imageRef.observeEventType(.Value, withBlock: { snapshot in
//            
//            let base64EncodedString = snapshot.value
//            let imageData = NSData(base64EncodedString: base64EncodedString as! String,
//                options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
//            let decodedImage = UIImage(data:imageData!)
//            self.imageView2.image = decodedImage
//            
//            }, withCancelBlock: { error in
//                print(error.description)
//        })
    }
    
   
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)

    }
    
    
}