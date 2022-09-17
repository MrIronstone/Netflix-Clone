//
//  CoreDataManager.swift
//  Netflix Clone
//
//  Created by admin on 13.09.2022.
//

import Foundation
import UIKit
import CoreData


class CoreDataManager {
    
    enum DBError: Error {
        case failedToSaveData
        case failedToFetchData
        case failtedToDeleteData
    }
    
    static let shared = CoreDataManager()
    
    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = TitleEntity(context: context)
        
        item.original_title = model.original_title
        item.name = model.name
        item.id = Int64(model.id)
        item.poster_path = model.poster_path
        item.overview = model.overview
        item.release_date = model.release_date
        item.media_type = model.media_type
        item.vote_count = Int64(model.vote_count!)
        item.vote_average = model.vote_average!
        
        do {
            try context.save()
            // empty paranthesis means void data
            completion(.success(()))
        } catch {
            completion(.failure(DBError.failedToSaveData))
        }
    }
    
    func fetchingDataFromDB(completion: @escaping (Result<[TitleEntity], Error>) -> ()) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleEntity>
        
        request = TitleEntity.fetchRequest()
        
        do {
            
            let titles = try context.fetch(request)
            completion(.success(titles))
            
            
        } catch {
            completion(.failure(DBError.failedToFetchData))
        }
        
    }
    
    
    func deleteTitleWith(model: TitleEntity, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DBError.failtedToDeleteData))
        }
    }
}
