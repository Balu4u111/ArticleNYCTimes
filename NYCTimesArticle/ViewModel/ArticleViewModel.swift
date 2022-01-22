//
//  ArticleViewModel.swift
//  NYCTimesArticle
//
//  Created by S P Balu Kommuri on 21/01/22.
//

import UIKit

class ArticleViewModel {
    
    var articles: [Article] = [Article]()
    var reloadTableView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    private var cellViewModels: [ArticleListCellViewModel] = [ArticleListCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    func getFilteredData(searchQuery:String) {
        if searchQuery.count >= 3 {
            let searchText = searchQuery.lowercased()
            var vms = [ArticleListCellViewModel]()
            for article in articles {
                if (article.title.lowercased().contains(searchText) || article.byline.lowercased().contains(searchText) || article.type.lowercased().contains(searchText)){
                    vms.append(ArticleListCellViewModel(article:article))
                }
            }
            cellViewModels = vms
            reloadTableView?()
        } else {
            createCell(articles: articles)
            reloadTableView?()
        }
    }
    
    func getData() {
        showLoading?()
        
        ApiClient.getDataFromServer(AppConstants.ApiConstants.kSection, timePeriod: 7) { [weak self] (success, data, error)  in
            self?.hideLoading?()
            if success {
                self?.createCell(articles: data!)
                self?.reloadTableView?()
            } else {
                self?.showError?()
            }
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> ArticleListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCell(articles: [Article]) {
        self.articles = articles
        var vms = [ArticleListCellViewModel]()
        for article in articles {
            vms.append(ArticleListCellViewModel(article:article))
        }
        cellViewModels = vms
    }
}

struct ArticleListCellViewModel {
    let article: Article
}
