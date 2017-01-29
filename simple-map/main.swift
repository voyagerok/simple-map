//
//  main.swift
//  simple-map
//
//  Created by Николай on 29.01.17.
//  Copyright © 2017 Николай. All rights reserved.
//

import Foundation

var map = Map<String, Int>()
map["John"] = 25
map["Pam"] = 22
map["Rick"] = 27
map["Kate"] = 40
map["John"] = 19
map.add(object: 45, forKey: "Anna")
print(map["John"]!)

for (key, value) in map {
    print("\(key) has salary \(value)")
}

