import UIKit

class ListLikedBooksCell: UITableViewCell {

    @IBOutlet weak var coverBookImage: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var authorsLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configure(wirth book: BookData) {
        coverBookImage.image = book.coverImage
        titleLable.text = book.title
        authorsLable.text = book.authors
    }
    
    @IBAction func optionButtonTapped(_ sender: Any) {
    }
}
