//
//  ViewController.swift
//  autoSizingCells
//
//  Created by kaww on 20/06/2020.
//  Copyright © 2020 rmluux. All rights reserved.
//

import UIKit

struct ChatMessage {
    var text: String
    var isIncoming: Bool
    var date: Date
}

extension Date {
    static func dateFromCustomString(_ customString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyy"
        return dateFormatter.date(from: customString) ?? Date()
    }
}

class DateHeaderLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(white: 0.80, alpha: 1)
        self.textColor = .black
        self.textAlignment = .center
        self.font = .systemFont(ofSize: 13, weight: .semibold)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        let height = originalSize.height + 12
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        return .init(width: originalSize.width + 12, height: height)
    }
    
}

class ViewController: UITableViewController {
    
    private let cellID = "cellID"
    
    var chatMessages = [
        [
            ChatMessage(text: "Hello !!", isIncoming: true, date: Date.dateFromCustomString("19/06/2020")),
            ChatMessage(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", isIncoming: true, date: Date.dateFromCustomString("19/06/2020")),
            ChatMessage(text: "Ut enim ad minim veniam.", isIncoming: false, date: Date.dateFromCustomString("19/06/2020")),
        ], [
            ChatMessage(text: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo !!", isIncoming: false, date: Date.dateFromCustomString("20/06/2020")),
            ChatMessage(text: "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit 😂", isIncoming: false, date: Date.dateFromCustomString("20/06/2020")),
        ], [
            ChatMessage(text: "Velit esse cillum dolore eu fugiat nulla pariatur velit esse cillum dolore eu fugiat nulla pariatur!", isIncoming: true, date: Date.dateFromCustomString("21/06/2020")),
            ChatMessage(text: "Excepteur sint occaecat cupidatat non, sunt in culpa qui officia deserunt mollit anim id est laborum...", isIncoming: false, date: Date.dateFromCustomString("21/06/2020")),
            ChatMessage(text: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum...", isIncoming: true, date: Date.dateFromCustomString("21/06/2020")),
            ChatMessage(text: "Excepteur cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum...", isIncoming: false, date: Date.dateFromCustomString("21/06/2020")),
            ChatMessage(text: "Quo voluptas nulla pariatur?", isIncoming: true, date: Date.dateFromCustomString("21/06/2020")),
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "messages"
        tableView.register(ChatBubleTableViewCell.self, forCellReuseIdentifier: self.cellID)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.15, alpha: 1)
        tableView.allowsSelection = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let lastIndex = NSIndexPath(item: chatMessages.last!.count - 1, section: chatMessages.count - 1)
        tableView.scrollToRow(at: lastIndex as IndexPath, at: .bottom, animated: false)
    }
}

// MARK: - TableView Delegates
extension ViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let firstMessageInSection = chatMessages[section].first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let dateString = dateFormatter.string(from: firstMessageInSection.date)
            
            let label = DateHeaderLabel()
            label.text = dateString
            
            let containerView = UIView()
            containerView.addSubview(label)
            containerView.backgroundColor = .clear
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            ])
            
            return containerView
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatMessages[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! ChatBubleTableViewCell
        cell.chatMessage = chatMessages[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (contextualAction, view, actionPerformed: (Bool) -> ()) in
            // perform delete
            self?.deleteMessage(at: indexPath)
            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
            actionPerformed(true)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
}


extension ViewController {
    
    private func deleteMessage(at indexPath: IndexPath) {
        chatMessages[indexPath.section].remove(at: indexPath.row)
    }
    
}
