 import UIKit

class LikedBooksViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case header = 0
        case listOfBooks
    }

    @IBOutlet weak var tableView: UITableView!
    
    var books: [BookData] = [
        BookData(coverImage: .weyward, title: "Weyward", authors: "Emilia Hart - 7h 5m"),
        BookData(coverImage: .theCovenantOfWater, title: "The Covenant of Water", authors: "Abraham Verghese - 2h 3m left"),
        BookData(coverImage: .ladyTansCircleOfWomen, title: "Lady Tan’s Circle of Women", authors: "Lisa See - 5h 5m"),
        BookData(coverImage: .theHeavenAndEarthGroceryStore, title: "The Heaven & Earth Grocery Store", authors: "James McBride - 2h 23m"),
        BookData(coverImage: .theEchoOfOldBooks, title: "The Echo of Old Books", authors: "Barbara Davis - 5h 2m"),
        BookData(coverImage: .theHouseOfEve, title: "The House of Eve", authors: "Sadeqa Johnson - 4h 5m"),
        BookData(coverImage: .theWindKnowsMyName, title: "The Wind Knows My Name", authors: "Isabel Allende - 4h 5m")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#0A0C2C")
        
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HeaderLikedBooksCell", bundle: nil), forCellReuseIdentifier: "HeaderLikedBooksCell")
        tableView.register(UINib(nibName: "ListLikedBooksCell", bundle: nil), forCellReuseIdentifier: "ListLikedBooksCell")
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
            return books.count
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
            
            let likedBook = books[indexPath.row]
            
            cell.configure(wirth: likedBook)
            
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
}
