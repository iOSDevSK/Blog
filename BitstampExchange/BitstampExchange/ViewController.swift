//
//  ViewController.swift
//  BitstampExchange
//
//  Created by Admin on 13/09/14.
//  Copyright (c) 2014 VANACOM s.r.o. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    //Nastavenie defaultnej meny USD
    @IBAction func buttonUSD(sender: UIButton) {
        
        self.setDefaultEurUSD("$")
        self.updateRate()

    }
    
    //Nastavenie defaultnej meny EURO
    
    @IBAction func buttonEUR(sender: UIButton) {
        
        self.setDefaultEurUSD("€")
        self.updateRate()
    
    }
    
    
    // Zistenie a nastavenie prvotnej defaultnej hodnoty prepoctu meny
    func getDefaultEurUSD() -> NSString {
        
        var defaultCurrency = NSUserDefaults(suiteName: "group.Vanacom.com.BitstampExchange")
        var currency:NSString? = defaultCurrency.stringForKey("currency")
        
        //Zisti defaulCurrency zo SharedValue (AppGroups)
        
        if currency == nil {
            currency = "$"
        }
        
        return "\(currency!)"
    }
    
    func setDefaultEurUSD(currency:NSString) {
        
        var defaultCurrency = NSUserDefaults(suiteName: "group.Vanacom.com.BitstampExchange")
        defaultCurrency.setObject(currency, forKey: "currency")
        defaultCurrency.synchronize()
        
    }
    
    
    
    //Zistenie aktuálneho kurzu zo stránky Bitstamp.net
    
    func getRate(path:String, objData: String) -> NSString {
        
        let url:NSURL = NSURL.URLWithString(path)
        let URLData:NSData = NSData.dataWithContentsOfURL(url, options: NSDataReadingOptions.allZeros,error: NSErrorPointer())
        let ret:NSString = NSString(data: URLData, encoding: NSUTF8StringEncoding)
        let myJSON:JSONDecode = JSONDecode()
        
        
        if let jsonResult = myJSON.JSON_Decode(ret) as? Dictionary<String, AnyObject>
        {
            
            var lastRate: AnyObject = jsonResult[objData]!
            return ("\(lastRate)")
        }
            
        else
        {
            return ("N/A")
        }
    }
    
    
    //Zistenie vymenneho kurzu EUR / USD
    
    func getEurUSD() -> Double{
        
        let buy:Double = self.getRate("https://www.bitstamp.net/api/eur_usd/", objData: "buy").doubleValue
        let sell:Double = self.getRate("https://www.bitstamp.net/api/eur_usd/", objData: "sell").doubleValue
        return (buy+sell)/2;
        
    }
    
    //Format Double na 2 desatinne miesta
    
    func niceValue(value:Double) ->NSString {
        
      return NSString(format:"%.2f", value)
        
    }
    
    //Zisti ulozenu menu, zobraz kurz k bitcoinu
    
    func updateRate() {
        
        var last:Double = self.getRate("https://www.bitstamp.net/api/ticker/",objData: "last").doubleValue
        //var last:Double = last_formated.doubleValue
        
        if getDefaultEurUSD() == "$" {
        self.priceLabel.text = "$\(last)"
        }
        else {
        var eur_price:Double = last / getEurUSD()
        var formated_eur_price:NSString = niceValue(eur_price)
        self.priceLabel.text = "\(formated_eur_price) €"
        }
    }
    
    
    //Zistenie času a nastavenie formátu
    
    func getTime() {
        
        let today = NSDate.date()
        let formater = NSDateFormatter()
        formater.dateFormat = "hh:mm:ss"
        self.updateRate()

    }
    
    
    override func viewDidLoad() {
        
       super.viewDidLoad()
       self.updateRate()
        
       dispatch_async(dispatch_get_main_queue(), {
            
            let aSelector : Selector = "getTime"
            let timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: aSelector, userInfo: nil, repeats: true)
           

        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

