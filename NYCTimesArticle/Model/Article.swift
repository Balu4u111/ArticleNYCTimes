//
//  Article.swift
//  NYCTimesArticle
//
//  Created by S P Balu Kommuri on 21/01/22.
//

import Foundation

struct ArticlesList: Codable {
    var results: [Article] = []
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let anArticle = try decoder.container(keyedBy: CodingKeys.self)
        results = try anArticle.decode([Article].self, forKey: .results)
    }
}

struct Article: Codable {
    
    var url: String
    var id: Int
    var asset_id: Int
    var source: String
    var published_date: String
    var updated: String
    var section: String
    var subsection: String
    var nytdsection: String
    var adx_keywords: String
    var byline: String
    var type: String
    var title: String
    var abstract: String
    var media: [Media] = []
    
    enum CodingKeys: String, CodingKey {
        
        case url
        case id
        case asset_id
        case source
        case published_date
        case updated
        case section
        case subsection
        case nytdsection
        case adx_keywords
        case byline
        case type
        case title
        case abstract
        case media
    }
    
    init(from decoder: Decoder) throws {
        
        let anArticle = try decoder.container(keyedBy: CodingKeys.self)
        
        url = try anArticle.decode(String.self, forKey: .url)
        id = try anArticle.decode(Int.self, forKey: .id)
        asset_id = try anArticle.decode(Int.self, forKey: .asset_id)
        source = try anArticle.decode(String.self, forKey: .source)
        published_date = try anArticle.decode(String.self, forKey: .published_date)
        updated = try anArticle.decode(String.self, forKey: .updated)
        section = try anArticle.decode(String.self, forKey: .section)
        subsection = try anArticle.decode(String.self, forKey: .subsection)
        nytdsection = try anArticle.decode(String.self, forKey: .nytdsection)
        adx_keywords = try anArticle.decode(String.self, forKey: .adx_keywords)
        byline = try anArticle.decode(String.self, forKey: .byline)
        type = try anArticle.decode(String.self, forKey: .type)
        title = try anArticle.decode(String.self, forKey: .title)
        abstract = try anArticle.decode(String.self, forKey: .abstract)
        media = try anArticle.decode([Media].self, forKey: .media)
    }
    
    struct Media: Codable {
        
        var type: String
        var subtype: String
        var caption: String
        var copyright: String
        var approved_for_syndication: Int
        var mediametadata:[Metadata] = []
        
        enum CodingKeys: String, CodingKey {
            case type
            case subtype
            case caption
            case copyright
            case approved_for_syndication
            case mediametadata = "media-metadata"
        }
        
        init(from decoder: Decoder) throws {
            
            let media = try decoder.container(keyedBy: CodingKeys.self)
            type = try media.decode(String.self, forKey: .type)
            subtype = try media.decode(String.self, forKey: .subtype)
            caption = try media.decode(String.self, forKey: .caption)
            copyright = try media.decode(String.self, forKey: .copyright)
            approved_for_syndication = try media.decode(Int.self, forKey: .approved_for_syndication)
            mediametadata = try media.decode([Metadata].self, forKey: .mediametadata)
        }
    }
    
    struct Metadata: Codable {
        var url: String
        var format: String
        var height: Int
        var width: Int
        
        enum CodingKeys: String, CodingKey {
            case url
            case format
            case height
            case width
        }
        
        init(from decoder: Decoder) throws {
            
            let mediaMetadata = try decoder.container(keyedBy: CodingKeys.self)
            url = try mediaMetadata.decode(String.self, forKey: .url)
            format = try mediaMetadata.decode(String.self, forKey: .format)
            height = try mediaMetadata.decode(Int.self, forKey: .height)
            width = try mediaMetadata.decode(Int.self, forKey: .width)
        }
    }
}
