//
//  Int+.swift
//  
//
//  Created by 史 翔新 on 2022/11/16.
//

extension Int {
    
    func formatted(digits: Int) -> String {
        String(format: "%0\(digits)d", self)
    }
    
}
