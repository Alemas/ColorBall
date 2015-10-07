//
//  Layout.swift
//  ColorBall
//
//  Created by Mateus Reckziegel on 7/31/15.
//  Copyright (c) 2015 Mateus Reckziegel. All rights reserved.
//

import UIKit

class Layout: NSObject {
   
    static var colorIndex = 1
    static var colorSet = [[UIColor(red:0.65490, green: 0.77254, blue: 0.12549, alpha: 1.0),
                            UIColor(red: 0.96078, green: 0.96470, blue: 0.83137, alpha: 1.0),
                            UIColor(red: 0.2863, green: 0.2471, blue: 0.0431, alpha: 1.0),
                            UIColor(red: 0.8039, green: 0.9098, blue: 0.3333, alpha: 1.0),
                            UIColor(red: 0.5216, green: 0.8588, blue: 0.0941, alpha: 1.0)],
        
                            [UIColor(red: 0.0627, green: 0.3569, blue: 0.3882, alpha: 1.0),
                            UIColor(red: 1.0, green: 0.9804, blue: 0.8353, alpha: 1.0),
                            UIColor(red: 1.0, green: 0.8275, blue: 0.3059, alpha: 1.0),
                            UIColor(red: 0.8588, green: 0.6196, blue: 0.2118, alpha: 1.0),
                            UIColor(red: 0.7412, green: 0.2863, blue: 0.1961, alpha: 1.0)
        ]
    ]
    static var pointRadius:CGFloat = 9.0
    static var lineWidth:CGFloat = 4.0
    
}
