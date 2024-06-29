//
//  CoreDataHeadLinesStorage.swift
//  NewsApp
//
//  Created by tarek ahmed on 24/06/2024.
//

import Foundation
import CoreData

final class CoreDataHeadLinesStorage {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataStack.shared.persistentContainer.newBackgroundContext()) {
        self.context = context
    }
}

extension CoreDataHeadLinesStorage: HeadLinesStorage {
    
    func deleteAllArticles() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleEntity")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
        } catch {
            print("Error deleting data: \(error)")
        }
        
    }
    
    func fetchArticles() throws -> [ArticleDTO]
    {
        let fetchRequest = NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
        let result = try context.fetch(fetchRequest)
        return result.map{$0.toDTO()}
    }
    
    func save(articles: [ArticleDTO]) {
        
        do {
            
            for article in articles {
                var article = article
                article.isHeadLine = true
                var _ = article.toEntity(in: context)
            }
            
            try context.save()
            
        } catch {
            debugPrint("CoreDataHeadLinesStorage Unresolved error \(error), \((error as NSError).userInfo)")
        }
        
    }
}




