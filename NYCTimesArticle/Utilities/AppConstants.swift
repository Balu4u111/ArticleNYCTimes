//
//  Constants.swift
//  NYCTimesArticle
//
//  Created by S P Balu Kommuri on 21/01/22.
//

struct AppConstants {
    struct ApiConstants {
        static let kApiKey = "9AdMgNZjVoMP82lgCGe4CLJHOCfw6bHD"
        static let kBaseUrl = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/"
        static let kFetchArticlesUri = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/%@/%d.json?api-key=%@"
        static let kSection = "all-sections"
    }
    
    struct CellIdentifier {
        static let kArticleIdentifier = "articleCell"
    }
}

struct SegueIdentifier {
    static let showDetailsPage = "showDetail"
}

struct Constants {
    static let kEmptyString = ""
    static let kOk = "Ok"
    static let errorMsg = "Show appropriate error "
}
