//
//  SimpleChildViewController.swift
//  CombineDemo
//
//  Created by Fu Jim on 2021/2/26.
//

import UIKit
import Combine

class SimpleChildViewController: UIViewController {
    
    let timeLabel: UILabel = {
       let label = UILabel()
        label.text = "這邊!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCombine()
    }
    
    private
    func setupView() {
        self.view.backgroundColor = .green

        self.view.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private
    func setupCombine() {
        let messagePublisher = NotificationCenter.Publisher(center: .default, name: .newMessage)
            .map { notification -> String? in
                if let message = (notification.object as? Message) {
                    return message.message + message.content
                }
                return nil
            }.print()
        
        let messageSubscriber = Subscribers.Assign(object: timeLabel, keyPath: \.text)
        messagePublisher.subscribe(messageSubscriber)
    }
}
