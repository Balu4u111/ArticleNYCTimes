//
//  ArticleCell.swift
//  NYCTimesArticle
//
//  Created by S P Balu Kommuri on 21/01/22.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet private (set) weak var imgView: UIImageView!
    @IBOutlet private (set) weak var date: UILabel!
    @IBOutlet private (set) weak var author: UILabel!
    @IBOutlet private (set) weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.applyRoundedShape()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func showArticle(_ article : Article?)  {
        title.text  = article?.title
        author.text = article?.byline
        date.text = "🗓 " + (article?.published_date)!
        if let media = article!.media.first {
            if  let metadata = media.mediametadata.first {
                imgView.setImageFor(urlString: (metadata.url))
            }
        }
    }
}
