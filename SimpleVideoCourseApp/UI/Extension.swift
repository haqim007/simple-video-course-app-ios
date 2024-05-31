//
//  Extension.swift
//  SimpleVideoCourseApp
//
//  Created by ADW Khaqim on 31/05/24.
//

import Foundation

extension URLCache {
    
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
