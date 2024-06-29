//
//  SearchStorageMock.swift
//  NewsAppTests
//
//  Created by tarek ahmed on 27/06/2024.
//

import Foundation
import Combine
import CoreData
@testable import NewsApp

class SearchStorageMock {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataStack.preview.persistentContainer.viewContext) {
        self.context = context
    }
    
}

extension SearchStorageMock : SearchStorage {
    
    func deleteAllArticles(word: String) {
        do {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SearchEntity")
            fetchRequest.includesPropertyValues = false // Optimize for deletion

            let objectsToDelete = try context.fetch(fetchRequest)

            for object in objectsToDelete {
                context.delete(object)
            }

            try context.save()
        } catch {
            debugPrint("CoreDataHeadLinesStorage Unresolved error \(error), \((error as NSError).userInfo)")
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
