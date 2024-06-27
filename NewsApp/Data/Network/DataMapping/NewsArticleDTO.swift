//
//  NewsArticleDTO.swift
//  NewsApp
//
//  Created by tarek ahmed on 23/06/2024.
//

import Foundation

// MARK: - Data Transfer Object

struct ArticleResponseDTO: Decodable {
    let articles: [ArticleDTO]
}

struct ArticleDTO: Decodable {
    var title: String?
    var author: String?
    var description: String?
    var publishedAt: String?
    var content: String?
    var sourceName: String?
    var url: String?
    var urlToImage: String?
    var isHeadLine = false
}

extension ArticleDTO {
    
    enum CodingKeys: String, CodingKey {
        case author, title, description, url, urlToImage, publishedAt, content , source
    }
    
    enum NestedKeys : String , CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: NestedKeys.self, forKey: .source)
        sourceName = try nestedContainer.decodeIfPresent(String.self, forKey: .name)
        author = try container.decodeIfPresent(String.self, forKey: .author)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
        publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt)
        content = try container.decodeIfPresent(String.self, forKey: .content)
    }
}


//// MARK: - Mappings to Domain

extension ArticleResponseDTO {
    func toDomain() -> ArticleResponse {
        return .init(articles: articles.map { $0.toDomain() } )
    }
}

extension ArticleDTO {
    func toDomain() -> Article {
        return .init(title: title ?? "", author: author ?? "", description: description ?? "", publishedAt: publishedAt ?? "", content: content ?? "", sourceName: sourceName ?? "",  url: url ?? "", urlToImage: urlToImage ?? "")
    }
}

enum PreviewArticleDTO {
    
    static var previewArticles : [ArticleDTO] {
        [
            ArticleDTO(
                title: "Detroit Lions legend Barry Sanders suffers 'health scare'",
                author: "Jeremy Reisman",
                description: "Detroit Lions legendary running back Barry Sanders said he suffered a ‘health scare’ over Father’s Day weekend.",
                publishedAt: "2024-06-21T22:00:20Z",
                content: "Detroit Lions legendary running back Barry Sanders revealed on Friday evening that over Father's Day weekend he suffered a recent medical episode. He experienced a health scare related to his heart.",
                sourceName: "Prideofdetroit.com",
                url: "https://www.prideofdetroit.com/2024/6/21/24183453/detroit-lions-legend-barry-sanders-suffers-health-scare-medical-update",
                urlToImage: "https://cdn.vox-cdn.com/thumbor/QwSZD0rZ3vodmu4DAWV3zUqCjqA=/0x385:6826x3959/fit-in/1200x630/cdn.vox-cdn.com/uploads/chorus_asset/file/25501153/2013429343.jpg"
            ),
            ArticleDTO(
                title: "Weight loss drug could help treat sleep apnea: Study",
                author: "Lauren Irwin",
                description: "A popular weight loss drug may be able to assist in the treatment of sleep apnea, a new study found.",
                publishedAt: "2024-06-21T22:00:00Z",
                content: "Tirzepatide, the medicine found in the drug Zepbound and the obesity drug Mounjaro, reduced the severity of sleep apnea, a disorder that causes breathing interruptions during sleep.",
                sourceName: "The Hill",
                url: "https://thehill.com/policy/healthcare/4734220-weight-loss-drug-could-help-treat-sleep-apnea-study/",
                urlToImage: "https://thehill.com/wp-content/uploads/sites/2/2024/04/GettyImages-2126120123-e1713372235593.jpg?w=1280"
            )
        ]
    }
}



