import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var authorsLable: UILabel!
    
    var book: BookData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func configure() {
        coverImage.image = book.coverBookImage
        titleLable.text = book.title
        authorsLable.text = book.authors
    }
    
    @IBAction func exitButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func commentsButton(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
        
        present(viewController, animated: true)
    }
}
