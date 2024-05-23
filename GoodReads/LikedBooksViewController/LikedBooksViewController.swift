 import UIKit

class LikedBooksViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case header = 0
        case listOfBooks
    }

    @IBOutlet weak var tableView: UITableView!
    
    var listOfBooks: [BookData] = [
        BookData(
            iconCoverImage: .weyward,
            coverBookImage: .weywardCover,
            title: "Weyward",
            authors: "Emilia Hart - 7h 5m"),
        BookData(
            iconCoverImage: .theCovenantOfWater,
            coverBookImage: .theCovenantOfWaterCover,
            title: "The Covenant of Water",
            authors: "Abraham Verghese - 2h 3m left"),
        BookData(
            iconCoverImage: .ladyTansCircleOfWomen,
            coverBookImage: .ladyTansCircleOfWomenCover,
            title: "Lady Tan’s Circle of Women",
            authors: "Lisa See - 5h 5m"),
        BookData(
            iconCoverImage: .theHeavenAndEarthGroceryStore,
            coverBookImage: .theHeavenAndEarthGroceryStoreCover,
            title: "The Heaven & Earth Grocery Store",
            authors: "James McBride - 2h 23m"),
        BookData(
            iconCoverImage: .theEchoOfOldBooks,
            coverBookImage: .theEchoOfOldBooksCover,
            title: "The Echo of Old Books",
            authors: "Barbara Davis - 5h 2m"),
        BookData(
            iconCoverImage: .theHouseOfEve,
            coverBookImage: .theHouseOfEveCover,
            title: "The House of Eve",
            authors: "Sadeqa Johnson - 4h 5m"),
        BookData(
            iconCoverImage: .theWindKnowsMyName,
            coverBookImage: .theWindKnowsMyNameCover,
            title: "The Wind Knows My Name",
            authors: "Isabel Allende - 4h 5m")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor(hex: "#0A0C2C")
        
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HeaderLikedBooksCell", bundle: nil), forCellReuseIdentifier: "HeaderLikedBooksCell")
        tableView.register(UINib(nibName: "ListLikedBooksCell", bundle: nil), forCellReuseIdentifier: "ListLikedBooksCell")
        tableView.rowHeight = 64
    }
    
    func present(with books: BookData) {
        let bookDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookDetailViewController") as! BookDetailViewController
        
        bookDetailViewController.modalPresentationStyle = .fullScreen
        bookDetailViewController.book = books
        
        present(bookDetailViewController, animated: true)
    }
    
    @IBAction func searchButton(_ sender: Any) {
    }
}

extension LikedBooksViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = Section(rawValue: section) else { return 0 }
        
        switch section {
        case .header:
            return 1
        case .listOfBooks:
            return listOfBooks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderLikedBooksCell", for: indexPath) as! HeaderLikedBooksCell
            return cell
            
        case .listOfBooks:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListLikedBooksCell") as? ListLikedBooksCell else { return UITableViewCell()}
            
            let likedBook = listOfBooks[indexPath.row]
            
            cell.configure(with: likedBook)
            
            return cell
        }
    }
}

extension LikedBooksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let section = Section(rawValue: indexPath.section) else { return 0 }
        
        switch section {
        case .header:
            return 300
        case .listOfBooks:
            return 64
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let section = Section(rawValue: indexPath.section), section == .listOfBooks else { return }
        
        let bookData = listOfBooks[indexPath.row]
        present(with: bookData)
    }
}
