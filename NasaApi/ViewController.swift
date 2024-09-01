//
//  ViewController.swift
//  NasaApi
//
//  Created by Deniz Otlu on 1.09.2024.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
      nasaFetch()
        view.addSubview(imageView)
        view.addSubview(textField)
        view.addSubview(label)
    }
    
    let imageView : UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 1, y: 70, width: 390, height: 440)
        image.backgroundColor = .red
        image.tintColor = .black
        return image
    }()
    
    let label : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 1, y: 515, width: 390, height: 40)
        label.backgroundColor = .systemPink
        
        return label
    }()
    
    let textField : UITextView = {
        let textfield = UITextView()
        textfield.frame = CGRect(x: 1, y: 560, width: 390, height: 250)
        textfield.backgroundColor = .brown
        return textfield
    }()
    
    
    
    func nasaFetch(){
        
        var request = URLRequest(url: URL(string: "https://api.nasa.gov/planetary/apod?api_key=DwifIJUbORwZRz3yg7cVXoKXe0G7TjUMGMC6cgMp")!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil{
                print(error?.localizedDescription ?? "error")
            }else{
                
                if data != nil{
                    do{
                        
                        if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                        {
                            let task = json["title"] as! String
                            let explanation = json["explanation"] as! String
                            let hdurl = json["hdurl"] as! String
                            
                            DispatchQueue.main.async {
                                self.label.text = task
                                self.textField.text = explanation
                                
                                do{
                                    self.imageView.image = UIImage(data: try Data(contentsOf: URL(string: hdurl)!))
                                }catch{
                                    print(error.localizedDescription)
                                }
                            }
                            
                        }

                    }catch{
                        print("cathcerror")
                    }
                    
                    
                    
                }
                
                
            }
        }.resume()
 
        
        
        
        
        
    }


}

#Preview{
    ViewController()
}

