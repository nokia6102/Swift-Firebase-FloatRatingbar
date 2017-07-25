

import UIKit
import Firebase


class ViewController: UIViewController {
 
    @IBOutlet weak var labelMyText: UILabel!
    @IBOutlet weak var txtInput: UITextView!
    @IBOutlet weak var txtOutput: UITextView!
  
    var  ref  : DatabaseReference!
    var output = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         ref = Database.database().reference(fromURL: "https://myfirebase-c064c.firebaseio.com/").child("test")
        obsRead1()
//         obsReadData()
//          obsAddData()
        
 
    }
 
    func obsRead1()
    {
        
        ref.observe(.value, with: { (snapshot) in
            for child in snapshot.children {
                let Value:DataSnapshot = child as! DataSnapshot
                print ( "> \(Value.value!)" )
                let  myValue = Value.value!
                if let dictionary  = myValue as? [String : Any]
                {
                    
                    if let description = dictionary["Description"] as? String
                    {   self.output.append(description)
                        self.output.append("\n")
                        print("1.Description: \(description)")
                    }
                    if let stars = dictionary["stars"] as? Float
                    {
                        print("2.stars: \(stars)")
                        self.output.append(String(stars))
                        self.output.append("\n")
                    }
                    self.txtOutput.text = self.output
                }

            }
        })
    }
    func obsReadData()
    {
        ref.observe(.value, with: { (snapshot) in
  
 
            
            let allJSON = snapshot.value    as!  [ String : Any]

            print ("\(allJSON)")
            
            var output = ""
            
        print ("snap child: \(snapshot.childrenCount)")
            
            for (key ,myValue) in allJSON
            
            {
                
                
                
                print ("--\(key)--")
                output.append("id:\(key)")
                output.append("\n")
                //                print (myValue)
                //
                if let dictionary  = myValue as? [String : Any]
                {
                    
                    if let description = dictionary["Description"] as? String
                    {   output.append(description)
                        output.append("\n")
                        print("Description: \(description)")
                    }
                    if let stars = dictionary["stars"] as? Float
                    {
                        print("stars: \(stars)")
                        output.append(String(stars))
                        output.append("\n")
                    }
                    self.txtOutput.text = output
                }
                print ("---88888---")
                
            }
        })

    }
    func obsAddData()
    {
        ref.observe(DataEventType.childAdded, with: { (sanpshot) in
            let allJSON = sanpshot.value   as!  [ String : Any]
            print ("\(allJSON)")
            
            var output = ""
            for (key ,myValue) in allJSON
            {
                
                print ("--\(key)--")
                output.append("id:\(key)")
                output.append("\n")
                //                print (myValue)
                //
                if let dictionary  = myValue as? [String : Any]
                {
                    
                    if let description = dictionary["Description"] as? String
                    {   output.append(description)
                        output.append("\n")
                        print("Description: \(description)")
                    }
                    if let stars = dictionary["stars"] as? Float
                    {
                        print("stars: \(stars)")
                        output.append(String(stars))
                        output.append("\n")
                    }
                    self.txtOutput.text = output
                }
                print ("-------")
                
            }
        })

    }
    
         @IBAction func pressButton(_ sender: UIButton)
    {
        
          ref = Database.database().reference(fromURL: "https://myfirebase-c064c.firebaseio.com/").child("test")

//          ref.setValue(txtInput.text)
    }

    @IBAction func btnSaveDictionary(_ sender: UIButton)
    {
//        obsChangeData()
        
        ref = Database.database().reference(fromURL: "https://myfirebase-c064c.firebaseio.com/").child("test").childByAutoId()
        let postInfo = ["Description": txtInput.text!, "ImageUrl": "test", "stars": 2.5] as [String : Any]
        
        
        ref.setValue(postInfo)
        
        let childautoID = ref.key
        print(childautoID)
        labelMyText.text = childautoID
      
        


    }

}

