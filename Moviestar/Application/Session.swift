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
        client = TMDbClient(apiKey: "2ff20a4ef65eda1c0f884a031a2d319f")
    }
}
