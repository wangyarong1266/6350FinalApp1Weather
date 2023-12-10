//
//  ViewController.swift
//  App1Weather
//
//  Created by rongbaobao888 on 12/9/23.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var weathers: [Weather] = [Weather]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeathers()
    }
    
    
    func getWeathers() {
        AF.request(baseURL).responseJSON { response in
            if response.error != nil {
                print(response.error!.localizedDescription)
            }
            guard let rawData = response.data else {return}
            guard let weathersJsonArray = JSON(rawData).array else {return}
            for weatherJson in weathersJsonArray {
                let cityCode = weatherJson["cityCode"].stringValue
                let city = weatherJson["city"].stringValue
                let temperature = weatherJson["temperature"].intValue
                let conditions = weatherJson["conditions"].stringValue
                
                let weather = Weather()
                weather.cityCode = cityCode
                weather.city = city
                weather.temperature = temperature
                weather.conditions = conditions
                
                self.weathers.append(weather)
            }
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
                let weather = weathers[indexPath.row]
        cell.textLabel?.text = " \(weather.cityCode)  \(weather.city)   \(weather.temperature)  \(weather.conditions)"
    
        return cell
    }
        
        

}

