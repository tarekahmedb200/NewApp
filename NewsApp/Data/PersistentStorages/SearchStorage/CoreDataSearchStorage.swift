//
//  CoreDataSearchStorage.swift
//  NewsApp
//
//  Created by tarek ahmed on 25/06/2024.
//

import Foundation
import CoreData

final class CoreDataSearchStorage {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataStack.shared.persistentContainer.newBackgroundContext()) {
        self.context = context
    }
}

extension CoreDataSearchStorage: SearchStorageProtocol {
    
    
    func deleteAllArticles(word:String) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchEntity")
        
        fetchRequest.predicate = NSPredicate(format: "wordQuery MATCHES %@", word)
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
        } catch {
            print("Error deleting data: \(error)")
        }
    }
    
    func fetchSearchedArticles(word:String) throws -> [ArticleDTO]
    {
        
        let fetchRequest = NSFetchRequest<SearchEntity>(entityName: "SearchEntity")
        
        fetchRequest.predicate = NSPredicate(format: "wordQuery MATCHES %@", word)
        
        let result = try context.fetch(fetchRequest).first
        let articlesSet = result?.articles ?? []
        let articlesArray = articlesSet.allObjects as? [ArticleEntity]
        return articlesArray?.map{$0.toDTO()} ?? []
    }
    
    func save(word:String,searchedArticles: [ArticleDTO]) {
        
        do {
            var searchedArticlesEntities = [ArticleEntity]()
            
            let searchEntity = SearchEntity(context: context)
            
            searchEntity.wordQuery = word
            
            for article in searchedArticles {
                searchedArticlesEntities.append(article.toEntity(in: context))
            }
            
            searchEntity.articles = NSSet(array: searchedArticlesEntities)
            
            try context.save()
            
        } catch {
            debugPrint("CoreDataSearchStorage Unresolved error \(error), \((error as NSError).userInfo)")
        }
        
    }
}
