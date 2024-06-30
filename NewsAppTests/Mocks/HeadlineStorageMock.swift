//
//  HeadlineStorageMock.swift
//  NewsAppTests
//
//  Created by tarek ahmed on 27/06/2024.
//

import Foundation
import Combine
import CoreData
@testable import NewsApp

class HeadlineStorageMock {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataStack.preview.persistentContainer.viewContext) {
        self.context = context
    }
    
}

extension HeadlineStorageMock : HeadLinesStorage {
    
    func deleteAllHeadlines() {
        
        do {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ArticleEntity")
            fetchRequest.includesPropertyValues = false // Optimize for deletion
            
            fetchRequest.predicate = NSPredicate(format: "isHeadLine == YES")
            
            let objectsToDelete = try context.fetch(fetchRequest)

            for object in objectsToDelete {
                context.delete(object)
            }

            try context.save()
        } catch {
            debugPrint("CoreDataHeadLinesStorage Unresolved error \(error), \((error as NSError).userInfo)")
        }
    }
    
    func fetchArticles() throws -> [ArticleDTO]
    {
        let fetchRequest = NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
        fetchRequest.predicate = NSPredicate(format: "isHeadLine == YES")
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

