//
//  APIConfiguration.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 20/10/2026.
//

import Foundation

enum APIConfiguration {
    static var tmdbAPIKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "TMDB_API_KEY") as? String,
              !key.isEmpty, !key.hasPrefix("$(") else {
            fatalError("TMDB_API_KEY не настроен")
        }
        return key
    }
}
