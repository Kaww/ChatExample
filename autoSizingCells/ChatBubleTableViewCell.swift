//
//  ChatBubleTableViewCell.swift
//  autoSizingCells
//
//  Created by kaww on 20/06/2020.
//  Copyright © 2020 rmluux. All rights reserved.
//

import UIKit

class ChatBubleTableViewCell: UITableViewCell {

    let messageLabel = UILabel()
    let messageView = UIView()
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    var chatMessage: ChatMessage! {
        didSet {
            messageLabel.text = chatMessage.text
            messageLabel.textColor = chatMessage.isIncoming ? .black : .white
            messageView.backgroundColor = chatMessage.isIncoming ? UIColor(white: 0.90, alpha: 1) : UIColor(white: 0.25, alpha: 1)
            if chatMessage.isIncoming {
                trailingConstraint.isActive = false
                leadingConstraint.isActive = true
            } else {
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        messageView.backgroundColor = .systemBlue
        messageView.translatesAutoresizingMaskIntoConstraints = false
        messageView.layer.cornerRadius = 10
        
        addSubview(messageView)
        
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font = .systemFont(ofSize: 15)
        messageLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 220),
            
            messageView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
            messageView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            messageView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
            messageView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16),
        ])
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32)
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
