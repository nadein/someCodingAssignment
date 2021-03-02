//
//  Movie.swift
//  API
//
//  Created by Frederik Christensen on 19/01/2021.
//

import Foundation
import Entities
import Client

extension Movie {
    public static func getNowPlaying() -> Request<Results<[Movie]>, APIError> {
        return Request(
            path: "/movie/now_playing",
            method: .get,
            parameters: [QueryParameters([.init(name: "region", value: "dk")])],
            resource: Results<[Movie]>.dataDecodeable(),
            error: APIError.init,
            needsAuthorization: true
        )
    }
  
    public static func getSearchResults(_ query: String) -> Request<Results<[Movie]>, APIError> {
        return Request(
            path: "/search/movie",
            method: .get,
            parameters: [QueryParameters([.init(name: "query", value: query)])],
            resource: Results<[Movie]>.dataDecodeable(),
            error: APIError.init,
            needsAuthorization: true
        )
    }
}
