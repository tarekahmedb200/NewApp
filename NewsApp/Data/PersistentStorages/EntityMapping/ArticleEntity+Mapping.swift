//
//  ArticleEntity+Mapping.swift
//  NewsApp
//
//  Created by tarek ahmed on 24/06/2024.
//

import Foundation
import CoreData

extension ArticleEntity {
    func toDTO() -> ArticleDTO {
        return .init(title: self.title, author: self.author, description: self.description, publishedAt: self.publishedAt, content: self.content, sourceName: self.sourceName, url: self.url, urlToImage: self.urlToImage)
    }
}

extension ArticleDTO {
    
    func toEntity(in context: NSManagedObjectContext) -> ArticleEntity {
        
        let entity: ArticleEntity = .init(context: context)
        entity.title = self.title
        entity.author = self.author
        entity.articleDescription = self.description ?? ""
        entity.publishedAt = self.publishedAt
        entity.content = self.content
        entity.sourceName = self.sourceName
        entity.url = self.url
        entity.urlToImage = self.urlToImage
        entity.isHeadLine = self.isHeadLine
        return entity
    }
}

