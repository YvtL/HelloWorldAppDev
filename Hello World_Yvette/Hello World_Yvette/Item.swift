//
//  Item.swift
//  Hello World_Yvette
//
//  Created by Yvette Luo on 9/9/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
