//
//  Double+Extension.swift
//  Home Report
//
//  Created by Sunny on 2016/10/18.
//  Copyright © 2016年 devhubs. All rights reserved.
//

import Foundation

extension Double{
    var currencyFormatter: String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
