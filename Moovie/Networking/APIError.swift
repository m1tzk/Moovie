//
//  APIError.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 11/10/2026.
//
import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case networkError(Error)
    case imageConversionError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "Переданный URL адрес не является действительным."
        case .invalidResponse:
            "Ошибка при ответе с сервера."
        case .decodingError(let error):
            "Ошибка при попытке декодировать ответ с сервера: \(error.localizedDescription)"
        case .networkError(let error):
            "Ошибка сети: \(error.localizedDescription)"
        case .imageConversionError:
            "Ошибка получения фотографии."
        }
    }
}
