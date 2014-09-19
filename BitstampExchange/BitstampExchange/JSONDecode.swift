//
//  JSONDecode.swift
//  BitstampExchangeRate
//
//  Created by Admin on 01/09/14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

import Foundation

class JSONDecode {
    
    func JSON_Decode(var jsonString:String)->AnyObject?{
        
        let jsonData:NSData! = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        return NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: NSErrorPointer())
        
    }
    
}
