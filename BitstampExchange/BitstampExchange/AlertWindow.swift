//
//  AlertWindow.swift
//  BitstampExchange
//
//  Created by Admin on 14/09/14.
//  Copyright (c) 2014 VANACOM s.r.o. All rights reserved.
//

import UIKit

//Štruktúra pre zobrazenie Alertu - Zjednodušenie definície
//Zavedaná z dôvôdu nefungujúcej kozoly println()
//Failed to inherit CoreMedia permissions

struct AlertWindow {
    
   static func ShowAlert(title:String, message:String, cancelTitle:String) {
       
        let myAlert = UIAlertView(title: title,
            message: message,
            delegate: nil, cancelButtonTitle: cancelTitle)
        myAlert.show()
        
    }
    
}