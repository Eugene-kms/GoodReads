import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var quantityLikesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configure(with comment: CommentData) {
        avatarImage.image = comment.avatar
        nameLabel.text = comment.name
        commentLabel.text = comment.comment
        quantityLikesLabel.text = comment.quantityLikes
    }

    @IBAction func optionsButton(_ sender: Any) {
    }
    @IBAction func likeButton(_ sender: Any) {
    }
    @IBAction func dislikeButton(_ sender: Any) {
    }
    @IBAction func commentButton(_ sender: Any) {
    }
}
