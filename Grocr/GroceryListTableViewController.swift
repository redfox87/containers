/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class GroceryListTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    struct Reference {
         static var ref = Firebase(url: "https://containers.firebaseio.com/grocery-items/")
         static var pathArray = ["https://containers.firebaseio.com/grocery-items/"]
        static var extraRef: String? = ""
        static var buttonRowRef: Int?
    }

//    @IBAction func infoButtonPressed(sender: UIButton) {
//        self.performSegueWithIdentifier("infoViewSegue", sender: UIButton())
//
//    }
  // MARK: Constants
  let ListToUsers = "ListToUsers"
  let imagePicker = UIImagePickerController()

  // MARK: Properties
  var items = [GroceryItem]()
//  var ref = Firebase(url: "https://containers.firebaseio.com/grocery-items/")
  let usersRef = Firebase(url: "https://grocr-app.firebaseio.com/online")
  var user: User!
  var backPath: UIBarButtonItem!
  var newPath = ""
//  var pathArray = ["https://containers.firebaseio.com/grocery-items/"]
  var newRef = ""
    var label1 = UILabel.self
    var label2 = UILabel.self
    
    
    
  // MARK: UIViewController Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    // Set up swipe to delete
    tableView.allowsMultipleSelectionDuringEditing = false
    
    // User Count
//    backPath = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: Selector(refresh))
//    backPath.tintColor = UIColor.redColor()
//    navigationItem.leftBarButtonItem = backPath
    
  }
  
  override func viewDidAppear(animated: Bool) {
    //var ref = Firebase(url: "https://containers.firebaseio.com/grocery-items/")
    super.viewDidAppear(animated)
    print(Reference.ref)
    // [1] Call the queryOrderedByChild function to return a reference that queries by the "completed" property
    Reference.ref = Firebase(url: Reference.pathArray[Reference.pathArray.count - 1])

    Reference.ref.queryOrderedByChild("completed").observeEventType(.Value, withBlock: { snapshot in
      
      var newItems = [GroceryItem]()
//        print(snapshot)
      
      for item in snapshot.children {
        
        if (item.value["name"] != nil && item.value["image"] != nil && item.value["completed"]  != nil && item.value["addedByUser"] != nil) {
            self.items = newItems
//            self.tableView.reloadData()
            
            let groceryItem = GroceryItem(snapshot: item as! FDataSnapshot)
            newItems.append(groceryItem)
        }
        self.items = newItems
        self.tableView.reloadData()
//        print(self.ref)
            //self.ref = snapshot.ref
        }})
            //print(groceryItem)
            //
//        }
      
      //self.tableView.reloadData()
       // print(snapshot.ref)
//        }
//        //self.items = newItems
//        //if (myRef == self.ref) {
//            self.items = newItems
//            self.tableView.reloadData()
    //}
//        })
    
    
    Reference.ref.observeAuthEventWithBlock { authData in
      
      if authData != nil {
        
        self.user = User(authData: authData)
        
        // Create a child reference with a unique id
        let currentUserRef = self.usersRef.childByAutoId()
        
        // Save the current user to the online users list
        currentUserRef.setValue(self.user.email)
        
        // When the user disconnects remove the value
        currentUserRef.onDisconnectRemoveValue()
      }
      
    }
    
    // Create a value observer
    usersRef.observeEventType(.Value, withBlock: { (snapshot: FDataSnapshot!) in
      
      // Check to see if the snapshot has any data
//      if snapshot.exists() {
//        
//        // Get the number of online users from the childrenCount property
//       // self.backPath.title = "Back"
//        }
//      } else {
//        self.userCountBarButtonItem?.title = "0"
//      }
    })
    
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    
  }
    func decodeImage(imageString base64: String) -> UIImage {
        let imageRef = Reference.ref.childByAppendingPath("image")
        
        
            
            let base64EncodedString = base64
            let imageData = NSData(base64EncodedString: base64EncodedString as! String,
                options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
            let decodedImage = UIImage(data:imageData!)
            //self.imageView2.image = decodedImage
            return UIImage(data:imageData!)!
            
        
   
    }
    
    
  // MARK: UITableView Delegate methods
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
   
  
    
    
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> GroceryCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! GroceryCell
    
    let groceryItem = items[indexPath.row]

    
    //cell.textLabel?.text = groceryItem.name
    cell.headingLabel?.text = groceryItem.name
    cell.button.setImage(decodeImage(imageString: groceryItem.image), forState: UIControlState.Normal)
    cell.button.tag = indexPath.row
    cell.button.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
//    cell.textLabel?.text = groceryItem.name
    cell.infoButton.tag = indexPath.row
   cell.infoButton.addTarget(self, action: "buttonClicked2:", forControlEvents: UIControlEvents.TouchUpInside)
   // cell.bkImageView.image = decodedImage

    
//    cell.detailTextLabel?.text = groceryItem.addedByUser
    
    // Determine whether the cell is checked
    //toggleCellCheckbox(cell, isCompleted: groceryItem.completed)
    
    return cell
  }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "infoViewSegue"{
//            if let indexPath = sender as? UIButton{
            //tableView.indexPathForSelectedRow()
//            {
//            
            let SecondVC: infoView = segue.destinationViewController as! infoView
            
//            let rowIndex: NSIndexPath = tableView.indexPathForSelectedRow!
//            let path = tableView.indexPathForSelectedRow
//            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(index: Reference.buttonRowRef!)) as! GroceryCell

            SecondVC.receivedText = items[Reference.buttonRowRef!].name
            SecondVC.receivedImage = decodeImage(imageString: items[Reference.buttonRowRef!].image)
            
            
        }}
    
    func buttonClicked(sender:UIButton) {
        let buttonRow = sender.tag
        var extraRef = String(items[buttonRow].ref!)
        Reference.ref = Firebase(url: extraRef)
//        performSegueWithIdentifier("pickerView", sender: nil)
        print(Reference.pathArray)
        print(buttonRow)
}
    func buttonClicked2(sender:UIButton){
        Reference.buttonRowRef = sender.tag
        print(Reference.buttonRowRef!)
        self.performSegueWithIdentifier("infoViewSegue", sender: self)
    
    
//          func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//            if segue.identifier == "infoViewSegue"{
//            var SecondVC: infoView = segue.destinationViewController as! infoView
//            
//            SecondVC.receivedText = items[buttonRowRef].name
//            SecondVC.receivedImage = decodeImage(imageString: items[buttonRowRef].image)
//                print(SecondVC.receivedImage)
//            }
//        }
//        
        }
    
    
//    func pickImage() {
//        
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//        imagePicker.allowsEditing = false
//        self.presentViewController(imagePicker, animated: true, completion: nil)
//    }
//    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        
//        dismissViewControllerAnimated(true, completion: nil)
//        
//       // var cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! GroceryCell
////        cell.displayImageView.image = image
//    }
    
   
  
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {

      // Find the snapshot and remove the value
      let groceryItem = items[indexPath.row]
      
      // Using the optional ref property, remove the value from the database
      groceryItem.ref?.removeValue()
      
    }
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    // Get the cell
    let cell = tableView.cellForRowAtIndexPath(indexPath)!
    
    // Get the associated grocery item
    let groceryItem = items[indexPath.row]
    // Get the new completion status
    let toggledCompletion = !groceryItem.completed
    let refPath = "https://containers.firebaseio.com/grocery-items/"
    
    
    newPath = newPath + groceryItem.name.lowercaseString + "/"
    
    var newRef = refPath
    if Reference.pathArray.count <= 0 {
    newRef = refPath + newPath
    Reference.pathArray.append(newRef)
    }
    else{
        Reference.pathArray.append((Reference.pathArray[Reference.pathArray.count - 1] + groceryItem.name.lowercaseString + "/"))
    }
    //newRef = pathArray[pathArray.count - 1]
    
    Reference.ref = Firebase(url: Reference.pathArray[Reference.pathArray.count - 1])
    
    
//    print(Reference.pathArray, Reference.pathArray.count)
    
    viewDidAppear(true)
    //self.tableView.reloadData()
    
    }
    

//    // Determine whether the cell is checked and modify it's view properties
//    toggleCellCheckbox(cell, isCompleted: toggledCompletion)
//    
//    // Call updateChildValues on the grocery item's reference with just the new completed status
//    groceryItem.ref?.updateChildValues([
//      "completed": toggledCompletion
//      ])
//  }
//  
//  func toggleCellCheckbox(cell: UITableViewCell, isCompleted: Bool) {
//    if !isCompleted {
//      cell.accessoryType = UITableViewCellAccessoryType.None
//      cell.textLabel?.textColor = UIColor.blackColor()
//      cell.detailTextLabel?.textColor = UIColor.blackColor()
//    } else {
//      cell.accessoryType = UITableViewCellAccessoryType.Checkmark
//      cell.textLabel?.textColor = UIColor.grayColor()
//      cell.detailTextLabel?.textColor = UIColor.grayColor()
//    }}
//    }
//  
  // MARK: Add Item
    @IBAction func backLoad(sender: UIBarButtonItem) {
        
        if Reference.pathArray.count >= 2 {
        Reference.ref = Firebase(url: Reference.pathArray[Reference.pathArray.count - 2])
        Reference.pathArray.removeLast()
            print(Reference.pathArray, Reference.pathArray.count)
            // self.tableView.reloadData()
            newPath = String(Reference.pathArray[Reference.pathArray.count - 1])
            self.viewDidAppear(true)
        }
        else{
            print("erase button")
            
        }
        
    }
  
  @IBAction func addButtonDidTouch(sender: AnyObject) {
    // Alert View for input
    let alert = UIAlertController(title: "Grocery Item",
      message: "Add an Item",
      preferredStyle: .Alert)
    
    let saveAction = UIAlertAction(title: "Save",
      style: .Default) { (action: UIAlertAction) -> Void in
        
        // Get the text field for the item name
        let textField = alert.textFields![0]
        let defaultimage = UIImage(named: "1")
        if let image = defaultimage {
                        let imageData = UIImageJPEGRepresentation(image, 0.2)
                        let base64String = imageData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
                        //print(base64String)
                        let imageRef = Reference.ref.childByAppendingPath("image")
            
                        imageRef.setValue(base64String)
            
                        imageRef.observeEventType(.Value, withBlock: { snapshot in
            
                            let base64EncodedString = snapshot.value
                            let imageData = NSData(base64EncodedString: base64EncodedString as! String,
                                options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
                            let decodedImage = UIImage(data:imageData!)
                            
                            }, withCancelBlock: { error in
                                print(error.description)
                        })
            
        // User must be set at Login or else error occours.
//            print(self.user.email)
//            print(base64String)
//            print(textField.text!)
        // Create the grocery item from the struct
        let groceryItem = GroceryItem(name: textField.text!, image: base64String, addedByUser: self.user.email, completed: false)
        
        let groceryItemRef = Reference.ref.childByAppendingPath(textField.text!.lowercaseString)
        // Save the grocery items in its AnyObject form
        groceryItemRef.setValue(groceryItem.toAnyObject())
        self.viewDidAppear(true)
        
        }
    }
    let cancelAction = UIAlertAction(title: "Cancel",
      style: .Default) { (action: UIAlertAction) -> Void in
    }
    
    alert.addTextFieldWithConfigurationHandler {
      (textField: UITextField!) -> Void in
        }
    
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    
    presentViewController(alert,
      animated: true,
      completion: nil)
  }
  
  
    
    
//  func userCountButtonDidTouch() {
//    performSegueWithIdentifier(ListToUsers, sender: nil)
  
}

