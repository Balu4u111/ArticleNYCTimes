//
//  ArticleListController.swift
//  NYCTimesArticle
//
//  Created by S P Balu Kommuri on 21/01/22.
//

import UIKit

class ArticleListController: UIViewController {
    
    @IBOutlet private (set) weak var tableView: UITableView!
    @IBOutlet private (set) weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private (set) weak var searchBar:UISearchBar!
    var searchModeOn:Bool = false
    
    var dataViewModel = ArticleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }
    
    func initViewModel(){
        dataViewModel.reloadTableView = {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
        dataViewModel.showError = {
            DispatchQueue.main.async { self.showAlert(Constants.errorMsg) }
        }
        dataViewModel.showLoading = {
            DispatchQueue.main.async { self.activityIndicator.startAnimating() }
        }
        dataViewModel.hideLoading = {
            DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
        }
        dataViewModel.getData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.showDetailsPage {
            if let indexPath = tableView.indexPathForSelectedRow {
                let news = dataViewModel.getCellViewModel(at: indexPath)
                let controller = segue.destination as? ArticleDetailsController
                controller?.detailItem = news.article
                controller?.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller?.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}

extension ArticleListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.CellIdentifier.kArticleIdentifier, for: indexPath) as? ArticleCell else {
            fatalError("Cell not exists in storyboard")
        }
        let cellVM = dataViewModel.getCellViewModel(at: indexPath)
        cell.showArticle(cellVM.article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: SegueIdentifier.showDetailsPage, sender: self)
    }
}

extension ArticleListController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        dataViewModel.getFilteredData(searchQuery: searchText)
    }
}

