//
//  Session.swift
//  Moviestar
//
//  Created by Frederik Christensen on 19/01/2021.
//

import Foundation
import API

final class Session {
    let client: TMDbClient

    init() {
        client = TMDbClient(apiKey: "<INSERT-API-KEY-HERE>")
    }
}
