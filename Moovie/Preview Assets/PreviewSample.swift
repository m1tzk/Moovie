//
//  PreviewSample.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 05/10/2026.
//
import Foundation
//import Playgrounds
//
//
//
//#Playground {
//    
//    let url = URL(string: "https://api.themoviedb.org/3/discover/movie")!
//    var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//    let queryItems: [URLQueryItem] = [
//        URLQueryItem(name: "language", value: "ru-RU"),
//        URLQueryItem(name: "page", value: "1"),
//        URLQueryItem(name: "sort_by", value: "popularity.desc"),
//    ]
//    components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
//    
//    var request = URLRequest(url: components.url!)
//    request.httpMethod = "GET"
//    request.timeoutInterval = 10
//    request.allHTTPHeaderFields = [
//        "accept": "application/json",
//        "Authorization": "Bearer ***REMOVED***"
//    ]
//    
//    do {
//        let (data, _) = try await URLSession.shared.data(for: request)
//        print(String(decoding: data, as: UTF8.self))
//    }
//}
