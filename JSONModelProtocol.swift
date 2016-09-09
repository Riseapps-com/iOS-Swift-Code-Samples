//
//  JSONModelProtocol.swift
//  Ruggengraat
//
//  Created by Dima Nikolayenko on 7/20/16.
//  Copyright © 2016 Dima Nikolayenko. All rights reserved.
//

import Foundation

protocol JSONModelProtocol {
    var id: Int {get}
    
    init(dict: Dictionary<String, AnyObject>)
}
