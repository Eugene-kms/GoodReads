import UIKit

class CommentsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    //Add item of add comment area
    @IBOutlet private weak var addNewCommentView: UIView!
    @IBOutlet private weak var addCommentSafeAreaView: UIView!
    @IBOutlet weak var addCommentSafeAreaViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var addCommentButton: UIButton!
    @IBOutlet weak var textFieldRightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureKeyboard()
        configurePlaceholderText()
        configureTextField()
        
        setAddCommentButton(enabled: false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    var comments: [CommentData] = [
        CommentData(
            avatar: .dayganatAvatar,
            name: "@dayganat - 2 months ago",
            comment: "Such a magnificent book. Haunting and hugely underrated",
            quantityLikes: "30"),
        
        CommentData(
            avatar: .sPenkevichAvatar,
            name: "@s.penkevich - 1 month ago",
            comment: "I find it hard to stay positive in this rubbish world.",
            quantityLikes: "226"),
        CommentData(
            avatar: .canadianJenAvatar,
            name: "@CanadianJen - 3 months ago",
            comment: "Allende is a master at spinning an epic story. I really wanted this one to ...",
            quantityLikes: "223"),
        CommentData(
            avatar: .theoverbookedbibliophileAvatar,
            name: "@theoverbookedbibliophile - 12 hours ago",
            comment: "In I938 Vienna, in the aftermath of Kristallnacht, six-year-old Samuel...",
            quantityLikes: "223"),
        CommentData(
            avatar: .angelaMAvatar,
            name: "@AngelaM - 3 months ago",
            comment: "In two different times, in two different places, under different and horrible...",
            quantityLikes: "118"),
        CommentData(
            avatar: .helgaAvatar,
            name: "@Helga - 3 months ago",
            comment: "There is a star where the people and the animals all live happily, and it’s even ...",
            quantityLikes: "105")
    ]
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
        tableView.rowHeight = 118
    }
    
    private func configureKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        let animationCurveRawNumber = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNumber?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRaw)
        
        let isKeyboardHidden = endFrame.origin.y >= UIScreen.main.bounds.size.height
        
        //If the keyboard is hidden
        if isKeyboardHidden {
            addCommentSafeAreaViewBottomConstraint.constant = 0
            textFieldRightConstraint.constant = 23
        } else {
            addCommentSafeAreaViewBottomConstraint.constant = -endFrame.height + view.safeAreaInsets.bottom - 8
            textFieldRightConstraint.constant = 55
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: animationCurve) {
            self.addCommentButton.alpha = isKeyboardHidden ? 0 : 1
            self.view.layoutIfNeeded()
        }
    }
    
    private func configurePlaceholderText() {
        
        let placeholdrText = "Add a comment..."
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor(hex: "#A7AEC1")]
        
        textField.attributedPlaceholder = NSAttributedString(string: placeholdrText, attributes: attributes as [NSAttributedString.Key : Any])
    }
    
    private func configureTextField() {
        textField.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
    }
    
    @objc private func didChangeText() {
        setAddCommentButton(enabled: isNewCommentValid)
    }
    
    private var isNewCommentValid: Bool {
        guard let text = textField.text else { return false }
        return !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private func setAddCommentButton(enabled isEnabled: Bool) {
        addCommentButton.isUserInteractionEnabled = isEnabled
        addCommentButton.tintColor = isEnabled ? UIColor(hex: "#FFFFFF") : UIColor(hex: "#FFFFFF")?.withAlphaComponent(0.2)
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func addCommentButtonTapped(_ sender: Any) {
        guard isNewCommentValid, let text = textField.text else { return }
        
        let itemTrimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        comments.append(CommentData(
            avatar: .addCommentIcon,
            name: "Anonymous",
            comment: itemTrimmed,
            quantityLikes: "0"))
        
        let indexPath = IndexPath(row: comments.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
        textField.text = ""
        setAddCommentButton(enabled: false)
    }
}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as? CommentCell else { return UITableViewCell() }
        
        let comment = comments[indexPath.row]
        
        cell.configure(with: comment)
        
        return cell
    }
}

extension CommentsViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
