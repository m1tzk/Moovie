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
//        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0YmU5MWFlOTU0YWZlYTkzMzE3ZDdjOGFhZmYwODRiZCIsIm5iZiI6MTc5MTE5NzAwOS4wNjMsInN1YiI6IjZhYzM3ZjUxZTI0ZDdhMDAzNDQ1NTg1YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kKMX5F3y3shNJFjWL07lsqXBoUM9ijwTC9wjT7pAbKU"
//    ]
//    
//    do {
//        let (data, _) = try await URLSession.shared.data(for: request)
//        print(String(decoding: data, as: UTF8.self))
//    }
//}
