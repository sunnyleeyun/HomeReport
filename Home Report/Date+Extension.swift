//
//  Date+Extension.swift
//  Home Report
//
//  Created by Sunny on 2016/10/18.
//  Copyright © 2016年 devhubs. All rights reserved.
//

import Foundation

extension Date {
    var toString: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: self)
    }
    
}
