//
//  ViewController.swift
//  Weather Application
//
//  Created by Chad Duffey on 10/04/2015.
//  Copyright (c) 2015 Chad Duffey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userCity: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    func showError(){
        resultLabel.text = "Was not able to find weather for " + userCity.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    @IBAction func findWeather(sender: AnyObject) {
        
        var url = NSURL(string: "http://www.weather-forecast.com/locations/" + userCity.text.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if url != nil {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, reponse, error) -> Void in
                
                var urlError = false
                
                var weather = ""
                
                if error == nil {
                    
                    var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
                    
                    var urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    if urlContentArray.count > 0 {
                        
                        var weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
                        
                        weather = weatherArray[0] as String
                        
                        weather = weather.stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                        
                        
                    }
                        
                    else {
                        urlError = true
                    }
                    
                } else {
                    urlError = true
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if urlError == true {
                        
                        self.showError()
                        
                    } else {
                        
                        self.resultLabel.text = weather
                        
                    }
                }
                
                
            })
            
            task.resume()
            
        } else {
            showError()
        }
    
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

