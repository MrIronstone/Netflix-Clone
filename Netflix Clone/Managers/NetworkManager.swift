//
//  NetworkManager.swift
//  Netflix Clone
//
//  Created by admin on 26.08.2022.
//

import Foundation


struct Constants {
    static let API_KEY = "d6715ac27b93b285c4c33a3ce1e485b9"
    static let baseURL = "https://api.themoviedb.org"
    static let GOOGLE_API_KEY = "AIzaSyCY4YOs3ckC6b9OR1mv_Rls3c4Io6AQr8c"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum NetworkManagerError: Error {
    case failedToGetData
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error >) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results =  try JSONDecoder().decode(TitlesResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(NetworkManagerError.failedToGetData))
            }
        })
        
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error >) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results =  try JSONDecoder().decode(TitlesResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(NetworkManagerError.failedToGetData))
            }
        })
        
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error >) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results =  try JSONDecoder().decode(TitlesResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(NetworkManagerError.failedToGetData))
            }
        })
        
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping (Result<[Title], Error >) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results =  try JSONDecoder().decode(TitlesResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(NetworkManagerError.failedToGetData))
            }
        })
        
        task.resume()
    }
    
    func getPopularTvs(completion: @escaping (Result<[Title], Error >) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/tv/popular?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results =  try JSONDecoder().decode(TitlesResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(NetworkManagerError.failedToGetData))
            }
        })
        
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Title], Error >) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/tv/top_rated?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results =  try JSONDecoder().decode(TitlesResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(NetworkManagerError.failedToGetData))
            }
        })
        
        task.resume()
    }
    
    func getTopRatedTvs(completion: @escaping (Result<[Title], Error >) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/tv/popular?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results =  try JSONDecoder().decode(TitlesResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(NetworkManagerError.failedToGetData))
            }
        })
        
        task.resume()
    }
        
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error >) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&sort_by=popularity.desc") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results =  try JSONDecoder().decode(TitlesResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(NetworkManagerError.failedToGetData))
            }
        })
        
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error >) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
         
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results =  try JSONDecoder().decode(TitlesResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(NetworkManagerError.failedToGetData))
            }
        })
        
        task.resume()
    }
    
    func getMovieTrailer(with query: String, completion: @escaping (Result<YoutubeVideo, Error >) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
    
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.GOOGLE_API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results =  try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            }
            catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        })
        
        task.resume()
    }
}
