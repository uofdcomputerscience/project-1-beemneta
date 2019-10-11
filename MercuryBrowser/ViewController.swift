//
//  ViewController.swift
//  MercuryBrowser
//
//  Created by Russell Mirabelli on 9/29/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
     @IBOutlet weak var tableView: UITableView!
    
    let urlString = "https://raw.githubusercontent.com/rmirabelli/mercuryserver/master/mercury.json"
    
    
    
    var arrayOfMercury = MercuryList(mercury:[])
    struct MercuryList: Codable {
        let mercury: [mercury]
    }
    
    struct mercury: Codable{
        let name: String
        let type: String
        let url: String
    }
    
 
    
    
    func geturlData (urlString: String) {
        let request = URL(string: urlString)!
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: request) { (data, response, error) in
            let mercuryList = try! JSONDecoder().decode(MercuryList.self, from: data!)
            self.arrayOfMercury = mercuryList
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
    
        }
        
        task.resume()
        
    }
       
   override func viewDidLoad() {
        tableView.dataSource = self
       super.viewDidLoad()
       // Do any additional setup after loading the view.
       geturlData(urlString: self.urlString)
    
    
    }
  
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfMercury.mercury.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rightLbl = arrayOfMercury.mercury[indexPath.item].type
        let leftLbl = arrayOfMercury.mercury[indexPath.item].name
        let urlString = arrayOfMercury.mercury[indexPath.item].url
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")!
        if let tablCell = cell as?
            tableCell{
            fillLeftLabel(tablecell: tablCell, string: leftLbl)
            fillRightLabel(tablecell: tablCell, string: rightLbl)
            fillImage(tablecell: tablCell, string: urlString)
        }
        
        return cell
    }
    //function to fill the left label with name in the tableCell
    func fillLeftLabel (tablecell : tableCell, string: String){
        tablecell.leftLabel.text = "\(string)"
    }
    //function to fill the right label with type in the tableCell
    func fillRightLabel (tablecell: tableCell, string: String){
        tablecell.rightLabel.text = "\(string)"
    }
    //function to fill image in the tableCell
    func fillImage (tablecell: tableCell, string: String){
        
        tablecell.imageView?.image = getImage(from: string)
    }
    // Code I borrowed from StackOverflow
    // To get image from url
    func getImage(from string: String) -> UIImage? {
        //2. Get valid URL
        guard let url = URL(string: string)
            else {
                print("Unable to create URL")
                return nil
        }
        var image: UIImage? = nil
        do {
            //3. Get valid data
            let data = try Data(contentsOf: url, options: [])
            //4. Make image
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }
        return image
    }
    
    
}


