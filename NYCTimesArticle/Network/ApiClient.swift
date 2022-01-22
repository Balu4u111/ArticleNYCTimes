//
//  ApiClient.swift
//  NYCTimesArticle
//
//  Created by S P Balu Kommuri on 21/01/22.
//

import Foundation

public struct ApiClient {
    
    static func getDataFromServer(_ section:String,
                                  timePeriod: Int,
                                  complete: @escaping (_ success: Bool,
                                                       _ articles: [Article]?,
                                                       _ _error: Error?)->() ) {
        guard let url = URL(string:String.init(format: AppConstants.ApiConstants.kFetchArticlesUri, section, timePeriod, AppConstants.ApiConstants.kApiKey)) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Parse response into model objects
            // If no data available return.
            guard let data = data else{
                return
            }

            do {
                let decoder = JSONDecoder()
                let allArticles = try decoder.decode(ArticlesList.self, from: data)
                complete(true, allArticles.results, nil)
            } catch let parseError {
                complete(false, nil, parseError)
            }
        }.resume()
    }
}
