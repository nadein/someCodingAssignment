//
//  APIError.swift
//  Client
//
//  Created by Frederik Christensen on 19/01/2021.
//

import Foundation

public struct APIError: Swift.Error {
    let errorData: Data
    
    public init(_ data: Data) {
        errorData = data
    }
}
