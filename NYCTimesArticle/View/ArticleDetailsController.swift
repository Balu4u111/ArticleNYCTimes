//
//  ArticleDetailsController.swift
//  NYCTimesArticle
//
//  Created by S P Balu Kommuri on 21/01/22.
//

import UIKit

class ArticleDetailsController: UIViewController {
    
    @IBOutlet private (set) weak var articleTitle: UILabel!
    @IBOutlet private (set) weak var imgView: UIImageView!
    @IBOutlet private (set) weak var dateLabel: UILabel!
    @IBOutlet private (set) weak var detailLabel: UILabel!
    @IBOutlet private (set) weak var additionalDetailLabel: UILabel!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let article  = detailItem  {
            if let title  = articleTitle  { title.text = article.title }
            if let date = dateLabel  { date.text = "🗓 " +   article.published_date }
            if let detailLabel  = detailLabel  { detailLabel.text = article.byline }
            if let additionalDetail  = additionalDetailLabel  { additionalDetail.text = article.abstract }
            if let media = article.media.first {
                if  let metadata = media.mediametadata.first {
                    imgView.setImageFor(urlString:metadata.url)
                    imgView.applyRoundedShape()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    var detailItem: Article? {
        didSet{}
    }
}
