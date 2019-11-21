//
//  ViewController.swift
//  Marvel
//
//  Created by Prog on 18/10/19.
//  Copyright © 2019 Prog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var TxtName: UITextField!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var LblName: UILabel!
    @IBOutlet weak var LblComics: UILabel!
    @IBOutlet weak var LblSeries: UILabel!
    @IBOutlet weak var LblStories: UILabel!
    @IBOutlet weak var LblEvents: UILabel!
    @IBOutlet weak var LblDescription: UILabel!
    
    @IBAction func GetInfo(_ sender: Any) {
        let character = TxtName.text!
        let encChar = character.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let key = "efe12de1954ab5dfb332e64f10216094"
        let Myhash = "d502f069a2a4e2c3c6ec8a07710added"
        let service = "https://gateway.marvel.com/v1/public/characters"
        let args = "name=\(encChar)&ts=1&apikey=\(key)&hash=\(Myhash)"
        let fullpath = "\(service)?\(args)"
        print(fullpath)
        
        if let url = URL(string: fullpath) {
            downloadInfo(url)
        }
        
        LblName.text = ""
        LblComics.text = ""
        LblSeries.text = ""
        LblStories.text = ""
        LblEvents.text = ""
        LblDescription.text = ""
    }
    
    func downloadInfo (_ url: URL) {
        URLSession.shared.dataTask(with: url) { (data, url, error) in do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
            
                let root: Root = try decoder.decode(Root.self, from: data!)
            
                DispatchQueue.main.async {
                    var pas = false
                    self.LblName.text = "\(root.data.results[0].name)"
                    self.LblComics.text = "\(root.data.results[0].comics.available)"
                    self.LblSeries.text = "\(root.data.results[0].series.available)"
                    self.LblStories.text = "\(root.data.results[0].stories.available)"
                    self.LblEvents.text = "\(root.data.results[0].events.available)"
                    self.LblDescription.text = "\(root.data.results[0].description)"
                    let Ipath = "\(root.data.results[0].thumbnail.path).jpg"
                    var IPath = "https://"
                    var temp = ""
                    
                    for char in Ipath{
                        temp = "\(temp)\(char)"
                        if temp == "http://" && !pas{
                            pas = true
                        }else if pas {
                            IPath = "\(IPath)\(char)"
                        }
                    }
                    print(IPath)
                    if let urlI = URL(string: IPath) {
                        self.downloadImage(urlI)
                    } 
                }
            }catch{
            }
            
        }.resume()
    }

    func downloadImage (_ url: URL) {
        URLSession.shared.dataTask(with: url) { (data, url, error) in
        if let ImagePath = data {
            DispatchQueue.main.async {
                self.Image.image = UIImage(data: ImagePath)
            }
        } 

        }.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

