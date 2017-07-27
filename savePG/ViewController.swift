

import UIKit
import Firebase


class ViewController: UIViewController,FloatRatingViewDelegate {
 
    @IBOutlet weak var floatRatingView: FloatRatingView!
    @IBOutlet weak var labelMyText: UILabel!
    @IBOutlet weak var txtInput: UITextView!
    @IBOutlet weak var txtOutput: UITextView!
  
    @IBOutlet weak var liveLabel: UILabel!
    @IBOutlet weak var updateLabel: UILabel!
    var floatStars : Float = 0.0
    var  ref  : DatabaseReference!
    var output = ""
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         ref = Database.database().reference(fromURL: "https://myfirebase-c064c.firebaseio.com/").child("test")
        obsRead1()
        
        /** Note: With the exception of contentMode, all of these
         properties can be set directly in Interface builder **/
        
        // Required float rating view params
        self.floatRatingView.emptyImage = UIImage(named: "StarEmpty")
        self.floatRatingView.fullImage = UIImage(named: "StarFull")
        // Optional params
        self.floatRatingView.delegate = self
        self.floatRatingView.contentMode = UIViewContentMode.scaleAspectFit
        self.floatRatingView.maxRating = 5
//        self.floatRatingView.minRating = 1
//        self.floatRatingView.rating = 2.5
//        self.floatRatingView.editable = true
//        self.floatRatingView.halfRatings = true
//        self.floatRatingView.floatRatings = false
        
//        // Segmented control init
//        self.ratingSegmentedControl.selectedSegmentIndex = 1
        
        // Labels init
        self.liveLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
        self.updateLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String

        
 
    }
 
    func obsRead1()
    {
        
        ref.observe(.value, with: { (snapshot) in
            
            (self.count >= 2) ? (self.count = 0) : (self.count += 1)
            if self.count == 0
            {
                self.output.removeAll()
            }

            
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
        let postInfo = ["Description": txtInput.text!, "ImageUrl": "test", "stars": floatStars ] as [String : Any]
        
        
        ref.setValue(postInfo)
        
        let childautoID = ref.key
        print(childautoID)
        labelMyText.text = childautoID
    }
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating:Float) {
        self.liveLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float) {
        floatStars = self.floatRatingView.rating
        self.updateLabel.text = NSString(format: "%.2f", self.floatRatingView.rating) as String
    }

}

